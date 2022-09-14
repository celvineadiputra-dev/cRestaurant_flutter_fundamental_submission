import 'package:crestaurant2/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SuggestCardLoading extends StatelessWidget {
  const SuggestCardLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.only(top: 16),
          child: Shimmer.fromColors(
            baseColor: grey2,
            highlightColor: Colors.grey[400]!,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: grey1, borderRadius: BorderRadius.circular(25)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 110,
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(right: 25, left: 25, bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0.1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                          width: 100,
                          height: 100,
                          color: grey2,
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
