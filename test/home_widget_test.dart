import 'package:crestaurant2/app/home/home_screen.dart';
import 'package:crestaurant2/provider/auth_provider.dart';
import 'package:crestaurant2/provider/navigation_provider.dart';
import 'package:crestaurant2/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets("Check widget in home page", (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        child: ChangeNotifierProvider<NavigationProvider>(
          create: (context) => NavigationProvider(),
          child: ChangeNotifierProvider<RestaurantProvider>(
            create: (context) => RestaurantProvider(),
            child: const MaterialApp(
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('id', ''),
                Locale('en', ''),
              ],
              locale: Locale("en"),
              home: HomeScreen(),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(ListView), findsNWidgets(2));
  });
}
