import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';

class CustomSnackBarContentWidget extends StatelessWidget {
  final String type;
  final String label;

  const CustomSnackBarContentWidget(
      {Key? key, required this.type, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: type == "error"
            ? lipstickRed
            : type == "info"
                ? seaBlue
                : type == "success"
                    ? acidGreen
                    : seaBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          type.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
