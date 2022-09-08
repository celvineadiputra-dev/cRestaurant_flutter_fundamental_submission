import 'package:crestaurant2/themes/text_theme.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: primary,
    textStyle: textTheme.button?.copyWith(fontSize: 16),
    padding: const EdgeInsets.symmetric(vertical: 20),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);
