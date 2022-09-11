import 'package:crestaurant2/models/item_menu_model.dart';
import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant data;

  const DetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)),
                  child: SvgPicture.asset(back),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: primary,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              flexibleSpace: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        width: double.infinity,
                        height: 350,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(data.pictureId),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 20,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  )),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [InfoRestaurant(data: data), DetailRestaurant(data: data)],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoRestaurant extends StatelessWidget {
  const InfoRestaurant({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Restaurant data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  RatingBar(
                    initialRating: data.rating,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: orange,
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: orange,
                        ),
                        empty: const Icon(
                          Icons.star_border,
                          color: grey1,
                        )),
                    onRatingUpdate: (double value) {},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(data.rating.toString())
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    map,
                    color: grey1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    data.city,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DetailRestaurant extends StatefulWidget {
  final Restaurant data;

  const DetailRestaurant({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  late int _activeTab = 0;
  List<Widget> listTab = [];

  @override
  void initState() {
    listTab = [
      DescContent(
        desc: widget.data.description,
      ),
      MenuContent(
        menu: widget.data.menus.foods,
      ),
      MenuContent(
        menu: widget.data.menus.drinks,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 28,
            child: DefaultTabController(
              length: 3,
              child: TabBar(
                isScrollable: true,
                indicatorPadding: const EdgeInsets.only(left: 32, right: 32),
                unselectedLabelColor: grey1,
                indicatorColor: primary,
                labelColor: primary,
                labelStyle: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                onTap: (index) {
                  setState(() {
                    _activeTab = index;
                  });
                },
                tabs: [
                  Tab(
                    child: Text(
                      "Description",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: dark),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Foods",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: dark),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Drinks",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: dark),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          listTab.isNotEmpty ? listTab[_activeTab] : Text("LOADING")
        ],
      ),
    );
  }
}

class DescContent extends StatelessWidget {
  final String desc;

  const DescContent({Key? key, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Text(desc),
    );
  }
}

class MenuContent extends StatelessWidget {
  final List<ItemMenuModel> menu;

  const MenuContent({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
        child: Wrap(
          spacing: 6,
          children: menu
              .map(
                (e) => ChoiceChip(
                  side: BorderSide.none,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                  selected: false,
                  label: Text(
                    e.name,
                  ),
                ),
              )
              .toList(),
        ));
  }
}
