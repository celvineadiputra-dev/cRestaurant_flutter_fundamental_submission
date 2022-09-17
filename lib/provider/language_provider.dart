import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale _locale = const Locale("en");

  Locale get locale => _locale;

  void setLanguage(Locale language) {
    _locale = language;
    notifyListeners();
  }
}
