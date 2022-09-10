import 'package:crestaurant2/app/detail/detail_screen.dart';
import 'package:crestaurant2/app/widgets/card_popular_widget.dart';
import 'package:crestaurant2/app/widgets/card_resto_widget.dart';
import 'package:crestaurant2/app/widgets/card_suggest_widget.dart';
import 'package:crestaurant2/app/widgets/menu_widget.dart';
import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/restaurant_service.dart';

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
      appBar: appBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SuggestRestaurant(),
              MenuItem(),
              SizedBox(
                height: 15,
              ),
              PopularRestaurantSection(),
              SizedBox(
                height: 15,
              ),
              HottestDiscountSection()
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
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
            Navigator.pushNamed(context, '/search');
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
  late List<Restaurant> suggestRestaurant = [];
  late int _itemSlideActive = 0;

  Future<void> fetchData() async {
    List<Restaurant> response =
        await RestaurantService().randomRestaurant(context);
    setState(() {
      suggestRestaurant = response;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    controller.addListener(() {
      setState(() {
        _itemSlideActive = controller.page!.floor();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return suggestRestaurant.isNotEmpty
        ? Column(
            children: [
              Container(
                height: 300,
                margin: const EdgeInsets.only(top: 16),
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (context, index) {
                    Restaurant data = suggestRestaurant![index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(data : data)));
                      },
                      child: CardSuggestWidget(
                        image: data.pictureId,
                        name: data.name,
                        rating: data.rating,
                        city: data.city,
                      ),
                    );
                  },
                  itemCount: suggestRestaurant.length,
                ),
              ),
              indicatorSlide(
                  itemCount: suggestRestaurant.length,
                  itemActive: _itemSlideActive)
            ],
          )
        : const Loading();
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

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const CircularProgressIndicator(
            color: primary,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Finding Resto Just For You",
            style: Theme.of(context).textTheme.subtitle1?.copyWith(color: dark),
          )
        ],
      ),
    );
  }
}

class PopularRestaurantSection extends StatelessWidget {
  const PopularRestaurantSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: lipstickRed,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    utensils,
                    color: Colors.white,
                    width: 10,
                    height: 10,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Popular Restaurant",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: dark, fontWeight: FontWeight.w900),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lots of good restaurants, loh!",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: dark, fontWeight: FontWeight.w700, fontSize: 15),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: flesh, borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "View All",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const PopularRestaurant(),
        ],
      ),
    );
  }
}

class PopularRestaurant extends StatefulWidget {
  const PopularRestaurant({Key? key}) : super(key: key);

  @override
  State<PopularRestaurant> createState() => _PopularRestaurantState();
}

class _PopularRestaurantState extends State<PopularRestaurant> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>?>(
      future: RestaurantService().getPopularRestaurant(context),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Loading();
        } else if (snapshot.hasError) {
          return const Loading();
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 170,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                Restaurant data = snapshot.data![index];
                return CardPopularWidget(
                  image: data.pictureId,
                  name: data.name,
                  city: data.city,
                  rating: data.rating,
                );
              },
              separatorBuilder: (BuildContext context, _) {
                return const SizedBox(
                  width: 5,
                );
              },
              itemCount: snapshot.data!.length,
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}

class HottestDiscountSection extends StatelessWidget {
  const HottestDiscountSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: seaBlue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    voucher,
                    color: Colors.white,
                    width: 10,
                    height: 10,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Hottest Discount",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: dark, fontWeight: FontWeight.w900),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Big discounts awaits",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: dark, fontWeight: FontWeight.w700, fontSize: 15),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: flesh, borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "View All",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const HottestDiscount(),
        ],
      ),
    );
  }
}

class HottestDiscount extends StatefulWidget {
  const HottestDiscount({Key? key}) : super(key: key);

  @override
  State<HottestDiscount> createState() => _HottestDiscountState();
}

class _HottestDiscountState extends State<HottestDiscount> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>?>(
      future: RestaurantService().getHottestRestaurant(context),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Loading();
        } else if (snapshot.hasError) {
          return const Loading();
        } else if (snapshot.hasData) {
          return ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Restaurant data = snapshot.data![index];
              return CardRestoWidget(
                image: data.pictureId,
                name: data.name,
                city: data.city,
                rating: data.rating,
              );
            },
            separatorBuilder: (BuildContext context, _) {
              return const SizedBox(
                width: 5,
              );
            },
            itemCount: snapshot.data!.length,
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
