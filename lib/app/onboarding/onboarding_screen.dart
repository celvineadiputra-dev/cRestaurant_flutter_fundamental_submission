import 'package:crestaurant2/app/signin/signin_screen.dart';
import 'package:crestaurant2/app/signup/signup_screen.dart';
import 'package:crestaurant2/app/widgets/button_widget.dart';
import 'package:crestaurant2/app/widgets/language_widget.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top -
                  30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LanguageWidget(widget: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              globe,
                              color: primary,
                            ),
                            Text(
                              AppLocalizations.of(context)!.language,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: grey1, fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                  ),),
                  const SizedBox(
                    height: 30,
                  ),
                  SvgPicture.asset(
                    food,
                    height: 190,
                    color: primary,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.onBoardingHeadline,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  ButtonWidget(
                    onPress: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: const SignInScreen(),
                            type: PageTransitionType.bottomToTopJoined,
                            duration: const Duration(milliseconds: 1200),
                            childCurrent: this),
                      );
                    },
                    label: AppLocalizations.of(context)!.signIn,
                    verticalPadding: 15,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    onPress: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: const SignUpScreen(),
                            type: PageTransitionType.bottomToTopJoined,
                            duration: const Duration(milliseconds: 1200),
                            childCurrent: this),
                      );
                    },
                    label: AppLocalizations.of(context)!.signUp,
                    bgColor: dark,
                    verticalPadding: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


