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
      appBar: AppBar(
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
              hintStyle: const TextStyle(
                  color: rockBottom, fontWeight: FontWeight.w500),
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
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: const [MenuItem()],
        ),
      )),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
