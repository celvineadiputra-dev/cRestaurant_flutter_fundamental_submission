import 'package:crestaurant2/app/signin/signin_screen.dart';
import 'package:crestaurant2/provider/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets("Check widget in signin page", (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
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
          home: SignInScreen(),
        ),
      ),
    );

    expect(find.byType(Text), findsWidgets);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
