import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale _locale = const Locale("en");

  Locale get locale => _locale;

  LanguageProvider() {
    initLanguage();
  }

  void initLanguage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _locale = Locale(pref.getString("defaultLanguage") ?? "en");
    notifyListeners();
  }

  void setLanguage(String language) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _locale = Locale(language);

    pref.setString("defaultLanguage", language);

    notifyListeners();
  }
}
