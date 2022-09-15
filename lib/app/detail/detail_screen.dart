import 'package:crestaurant2/app/widgets/error_widget.dart';
import 'package:crestaurant2/models/category_model.dart';
import 'package:crestaurant2/models/customer_review_model.dart';
import 'package:crestaurant2/models/item_menu_model.dart';
import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/provider/detail_restaurant_provider.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant data;

  const DetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(5),
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
            flexibleSpace: SizedBox(
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

  Widget tabOn(
      {required int index,
      required List<ItemMenuModel> foods,
      required List<ItemMenuModel> drinks,
      required List<Category> category}) {
    listTab = [
      DescContent(
        desc: widget.data.description,
        category: category,
      ),
      MenuContent(
        menu: foods,
      ),
      MenuContent(
        menu: drinks,
      ),
    ];
    return listTab[index];
  }

  @override
  void initState() {
    super.initState();
    final detailRestaurantProvider =
        Provider.of<DetailRestaurantProvider>(context, listen: false);
    detailRestaurantProvider.fetchDetail(id: widget.data.id);
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DetailRestaurantProvider>(context);
    switch (dataProvider.state) {
      case ResultState.loading:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(color: primary,)
          ],
        );
      case ResultState.connectionError:
        return noConnection();
      case ResultState.noData:
        return notFound();
      case ResultState.hasData:
        return Column(
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
            tabOn(
                index: _activeTab,
                foods: dataProvider.detailRestaurant!.menus.foods,
                drinks: dataProvider.detailRestaurant!.menus.drinks,
                category: dataProvider.detailRestaurant!.categories)
          ],
        );
      case ResultState.error:
        return errorCode();
      default:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(color: primary,)
          ],
        );
    }
  }
}

class DescContent extends StatelessWidget {
  final String desc;
  final List<Category> category;

  const DescContent({Key? key, required this.desc, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          category.isNotEmpty
              ? SizedBox(
                  height: 40,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ChoiceChip(
                          side: BorderSide.none,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                          label: Text(category[index].name),
                          selected: false,
                        );
                      },
                      separatorBuilder: (BuildContext context, _) {
                        return const SizedBox(
                          width: 5,
                        );
                      },
                      itemCount: category.length),
                )
              : const Text(""),
          ExpandableText(
            desc,
            expandText: "Read More",
            maxLines: 4,
            animation: true,
            collapseText: "Read Less",
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(color: grey1),
            textAlign: TextAlign.justify,
            linkColor: primary,
          ),
          const SizedBox(
            height: 20,
          ),
          const GiveReview(),
          const SizedBox(
            height: 12,
          ),
          const RatingReview()
        ],
      ),
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

class RatingReview extends StatelessWidget {
  const RatingReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Rating and Review",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 20,
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          "Rating and review from awesome user",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: dark, fontWeight: FontWeight.w300, fontSize: 10),
        ),
        Consumer<DetailRestaurantProvider>(
          builder: (context, DetailRestaurantProvider data, _) {
            return ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  CustomerReview review =
                      data.detailRestaurant!.customerReviews[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 15,
                                backgroundColor: grey1,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(review.name)
                            ],
                          ),
                          const Icon(
                            Icons.more_vert,
                            color: grey1,
                            size: 19,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          RatingBar(
                            initialRating: 4.5 - (index - 0.4),
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 12,
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
                            width: 5,
                          ),
                          Text(
                            review.date,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        review.review,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, _) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: data.detailRestaurant!.customerReviews.length);
          },
        )
      ],
    );
  }
}

class GiveReview extends StatelessWidget {
  const GiveReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Give your review for this restaurant",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          RatingBar(
            initialRating: 0,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 40,
            itemPadding: const EdgeInsets.symmetric(horizontal: 10),
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
            onRatingUpdate: (double value) {
              Navigator.pushNamed(context, '/review');
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/review');
                  },
                  child: Text(
                    "Write review",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: primary, fontSize: 12),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
