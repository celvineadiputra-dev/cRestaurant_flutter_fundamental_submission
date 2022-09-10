import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardSuggestWidget extends StatelessWidget {
  const CardSuggestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 220,
          margin: const EdgeInsets.only(right: 5, left: 5),
          decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                    "https://restaurant-api.dicoding.dev/images/medium/15"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(25)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 110,
            width: double.infinity,
            margin: const EdgeInsets.only(right: 25, left: 25, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Kafein",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      children: List.generate(
                        5,
                        (index) => SvgPicture.asset(
                          star,
                          width: 12,
                          color: orange,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "5.0",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontSize: 12),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    SvgPicture.asset(
                      map,
                      width: 18,
                      color: grey1,
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      "City",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: grey1, fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
