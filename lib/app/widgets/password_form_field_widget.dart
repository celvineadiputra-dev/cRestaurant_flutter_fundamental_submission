import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PasswordFormFieldWidget extends StatefulWidget {
  final TextEditingController valueController;
  final String label;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  const PasswordFormFieldWidget({
    Key? key,
    required this.valueController,
    required this.label,
    this.validator,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  State<PasswordFormFieldWidget> createState() =>
      _PasswordFormFieldWidgetState();
}

class _PasswordFormFieldWidgetState extends State<PasswordFormFieldWidget> {
  late bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      maxLines: 1,
      cursorColor: orange,
      textAlignVertical: TextAlignVertical.center,
      controller: widget.valueController,
      obscureText: _isObscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.label,
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
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isObscureText = !_isObscureText;
            });
          },
          icon: _isObscureText
              ? SvgPicture.asset(
            eye,
            color: grey1,
          )
              : SvgPicture.asset(
            eyeSlash,
            color: grey1,
          ),
        ),
      ),
    );
  }
}