import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CardRestoWidget extends StatelessWidget {
  final String image, name, city;
  final double rating;

  const CardRestoWidget(
      {Key? key,
      required this.image,
      required this.name,
      required this.city,
      required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.2,
      child: Row(
        children: [
          Container(
            width: 110,
            height: 86,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(12)),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: dark, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                city,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: dark, fontSize: 14),
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
                        .bodyText1
                        ?.copyWith(color: dark, fontSize: 12),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
