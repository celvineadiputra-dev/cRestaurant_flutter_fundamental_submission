import 'package:crestaurant2/app/onboarding/onboarding_screen.dart';
import 'package:crestaurant2/app/signin/signin_screen.dart';
import 'package:crestaurant2/themes/button_theme.dart';
import 'package:crestaurant2/themes/text_theme.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CRestaurant",
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'GoogleSans',
          textTheme: textTheme,
          primaryColor: primary,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: elevatedButtonTheme),
      routes: {
        '/': (context) => const OnBoardingScreen(),
        '/signin': (context) => const SignInScreen()
      },
    );
  }
}
