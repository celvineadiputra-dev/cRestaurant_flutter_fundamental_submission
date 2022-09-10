import 'dart:ffi';

import 'package:crestaurant2/app/widgets/card_suggest_widget.dart';
import 'package:crestaurant2/app/widgets/menu_widget.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            children: [SuggestRestaurant(), MenuItem()],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primary,
      title: SizedBox(
        height: 43,
        child: TextFormField(
          maxLines: 1,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: primary,
          readOnly: true,
          onTap: () {
            // Navigator.of(context)
            //     .push(RouteAnimationBottomUp(screen: const SearchPage()));
          },
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            hintText: "Search your favorite restaurant",
            hintStyle:
                const TextStyle(color: rockBottom, fontWeight: FontWeight.w500),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: 5,
                child: SvgPicture.asset(
                  search,
                  color: rockBottom,
                ),
              ),
            ),
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(color: Colors.white),
              child: SvgPicture.asset(
                profile,
                color: primary,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          MenuWidget(
            label: "Vouchers",
            color: ambrosiaIvory,
            icon: voucher,
          ),
          MenuWidget(
            label: "Dessert",
            color: lilyWhite,
            icon: ice,
          ),
          MenuWidget(
            label: "Fast food",
            color: earlyDawn,
            icon: fastFood,
          ),
          MenuWidget(
            label: "Diet food",
            color: feta,
            icon: dietFood,
          ),
        ],
      ),
    );
  }
}

class SuggestRestaurant extends StatefulWidget {
  const SuggestRestaurant({Key? key}) : super(key: key);

  @override
  State<SuggestRestaurant> createState() => _SuggestRestaurantState();
}

class _SuggestRestaurantState extends State<SuggestRestaurant> {
  PageController controller = PageController(viewportFraction: 0.90);
  late int _itemSlideActive = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        _itemSlideActive = controller.page!.floor();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          margin: const EdgeInsets.only(top: 16),
          child: PageView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              return CardSuggestWidget();
            },
            itemCount: 3,
          ),
        ),
        indicatorSlide(itemCount: 3, itemActive: _itemSlideActive)
      ],
    );
  }

  Widget indicatorSlide({required int itemCount, required int itemActive}) {
    return Wrap(
      children: List.generate(
        itemCount,
        (index) => Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: itemActive == index ? primary : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: itemActive == index ? Colors.white : primary, width: 2),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 5),
        ),
      ),
    );
  }
}
