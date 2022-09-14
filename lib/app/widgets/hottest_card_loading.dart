import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HottestCardLoading extends StatelessWidget {
  const HottestCardLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: grey2,
          highlightColor: Colors.grey[400]!,
          child: Card(
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 110,
                  height: 86,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
      itemCount: 4,
    );
  }
}
