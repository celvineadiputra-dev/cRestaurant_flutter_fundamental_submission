import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController valueController;
  final String label;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  const TextFormFieldWidget({
    Key? key,
    required this.valueController,
    required this.label,
    this.validator,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      maxLines: 1,
      cursorColor: orange,
      textAlignVertical: TextAlignVertical.center,
      controller: valueController,
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        hintStyle:
            Theme.of(context).textTheme.bodyText1?.copyWith(color: grey1),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: grey1),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: primary),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: lipstickRed),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: lipstickRed),
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: const TextStyle(color: lipstickRed),
      ),
    );
  }
}
