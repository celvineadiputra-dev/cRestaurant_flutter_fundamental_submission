import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant data;

  const DetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(data.pictureId), fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            top: 45,
            left: 20,
            right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)),
                  child: SvgPicture.asset(
                    back,
                    width: 30,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 350 - 30,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Description(
                                desc: data.description,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Text("Foods"),
                                    Wrap(
                                      children: data.menus.foods
                                          .map((e) => ChoiceChip(
                                              label: Text(e.name),
                                              selected: false))
                                          .toList(),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.desc,
  }) : super(key: key);

  final String desc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandableText(
            desc,
            expandText: "Read more",
            collapseText: "Read less",
            maxLines: 4,
            linkColor: primary,
          ),
        ],
      ),
    );
  }
}
