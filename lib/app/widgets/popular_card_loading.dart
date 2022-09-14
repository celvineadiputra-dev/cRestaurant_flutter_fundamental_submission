import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PopularCardLoading extends StatelessWidget {
  const PopularCardLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Shimmer.fromColors(
              baseColor: grey2,
              highlightColor: Colors.grey[400]!,
              child: Card(
                color: Colors.white,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 120,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, _) {
            return const SizedBox(
              width: 5,
            );
          },
          itemCount: 3),
    );
  }
}
