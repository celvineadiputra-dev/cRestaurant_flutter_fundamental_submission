import 'package:crestaurant2/app/main/main_screen.dart';
import 'package:crestaurant2/app/onboarding/onboarding_screen.dart';
import 'package:crestaurant2/app/profile/profile_screen.dart';
import 'package:crestaurant2/app/review/review_screen.dart';
import 'package:crestaurant2/app/search/search_screen.dart';
import 'package:crestaurant2/app/signin/signin_screen.dart';
import 'package:crestaurant2/app/signup/signup_screen.dart';
import 'package:crestaurant2/provider/auth_provider.dart';
import 'package:crestaurant2/provider/database_provider.dart';
import 'package:crestaurant2/provider/detail_restaurant_provider.dart';
import 'package:crestaurant2/provider/language_provider.dart';
import 'package:crestaurant2/provider/navigation_provider.dart';
import 'package:crestaurant2/provider/restaurant_provider.dart';
import 'package:crestaurant2/provider/search_restaurant_provider.dart';
import 'package:crestaurant2/themes/button_theme.dart';
import 'package:crestaurant2/themes/text_theme.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider<RestaurantProvider>(
            create: (context) => RestaurantProvider()),
        ChangeNotifierProvider(create: (context) => DetailRestaurantProvider()),
        ChangeNotifierProvider(create: (context) => SearchRestaurantProvider()),
        ChangeNotifierProvider(create: (context) => DatabaseProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (BuildContext context, language, _){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "CRestaurant",
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('id', ''),
              Locale('en', ''),
            ],
            locale: language.locale,
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
              '/search': (context) => const SearchScreen(),
              '/review': (context) => const ReviewScreen(),
              '/profile': (context) => const ProfileScreen()
            },
          );
        },
      ),
    );
  }
}
