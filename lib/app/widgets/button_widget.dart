import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() onPress;
  final String label;
  final double verticalPadding;
  final Color bgColor;
  final bool isLoading;

  const ButtonWidget(
      {Key? key,
      required this.onPress,
      required this.label,
      this.verticalPadding = 20,
      this.isLoading = false,
      this.bgColor = primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
        ),
        child: Text(label),
      ),
    );
  }
}
