import 'package:crestaurant2/app/signin/signin_screen.dart';
import 'package:crestaurant2/app/signup/signup_screen.dart';
import 'package:crestaurant2/app/widgets/button_widget.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                SvgPicture.asset(
                  food,
                  height: 190,
                  color: primary,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Find restaurant is what the world was waiting for taste",
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
                  label: "Sign In",
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
                  label: "Sign Up",
                  bgColor: dark,
                  verticalPadding: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
