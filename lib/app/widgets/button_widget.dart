import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() onPress;
  final String label;
  final double verticalPadding;
  final Color bgColor, textColor;
  final bool isLoading;

  const ButtonWidget(
      {Key? key,
      required this.onPress,
      required this.label,
      this.verticalPadding = 20,
      this.isLoading = false,
      this.textColor = Colors.white,
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
        child: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(label, style: Theme.of(context).textTheme.button!.copyWith(color: textColor),),
      ),
    );
  }
}
