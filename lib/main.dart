import 'dart:io';

import 'package:crestaurant2/app/main/main_screen.dart';
import 'package:crestaurant2/app/onboarding/onboarding_screen.dart';
import 'package:crestaurant2/app/signin/signin_screen.dart';
import 'package:crestaurant2/app/signup/signup_screen.dart';
import 'package:crestaurant2/themes/button_theme.dart';
import 'package:crestaurant2/themes/text_theme.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // var overlayStyle = SystemUiOverlayStyle(
  //   statusBarColor: primary,
  //   statusBarIconBrightness: Brightness.dark,
  //   statusBarBrightness:
  //       Platform.isAndroid ? Brightness.dark : Brightness.light,
  //   systemNavigationBarColor: primary,
  //   systemNavigationBarDividerColor: primary,
  //   systemNavigationBarIconBrightness: Brightness.dark,
  // );
  //
  // SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  // SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(statusBarColor: primary));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CRestaurant",
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'GoogleSans',
        textTheme: textTheme,
        primaryColor: primary,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: elevatedButtonTheme,
      ),
      routes: {
        '/': (context) => const OnBoardingScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/main': (context) => const MainScreen()
      },
    );
  }
}
