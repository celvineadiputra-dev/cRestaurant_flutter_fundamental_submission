import 'package:crestaurant2/app/main/main_screen.dart';
import 'package:crestaurant2/app/onboarding/onboarding_screen.dart';
import 'package:crestaurant2/app/search/search_screen.dart';
import 'package:crestaurant2/app/signin/signin_screen.dart';
import 'package:crestaurant2/app/signup/signup_screen.dart';
import 'package:crestaurant2/provider/auth_provider.dart';
import 'package:crestaurant2/provider/detail_restaurant_provider.dart';
import 'package:crestaurant2/provider/restaurant_provider.dart';
import 'package:crestaurant2/provider/search_restaurant_provider.dart';
import 'package:crestaurant2/themes/button_theme.dart';
import 'package:crestaurant2/themes/text_theme.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider<RestaurantProvider>(create: (context) => RestaurantProvider()),
        ChangeNotifierProvider(create: (context) => DetailRestaurantProvider()),
        ChangeNotifierProvider(create: (context) => SearchRestaurantProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "CRestaurant",
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'GoogleSans',
            textTheme: textTheme,
            primaryColor: primary,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: elevatedButtonTheme,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent),
        routes: {
          '/': (context) => const OnBoardingScreen(),
          '/signin': (context) => const SignInScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/main': (context) => const MainScreen(),
          '/search': (context) => const SearchScreen()
        },
      ),
    );
  }
}
