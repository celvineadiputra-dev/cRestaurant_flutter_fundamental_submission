import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CardPopularWidget extends StatelessWidget {
  final String image, name, city;
  final double rating;

  const CardPopularWidget(
      {Key? key,
      required this.image,
      required this.name,
      required this.city,
      required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      color: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: 120,
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.length > 12 ? '${name.substring(0, 12)}...' : name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  city,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 10,
                      ),
                ),
                Row(
                  children: [
                    RatingBar(
                      initialRating: rating,
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
                      width: 5,
                    ),
                    Text(
                      rating.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontSize: 10, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
