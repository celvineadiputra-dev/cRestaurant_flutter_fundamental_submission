import 'package:crestaurant2/app/widgets/button_widget.dart';
import 'package:crestaurant2/values/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              focus,
              width: 300,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "COMING SOON",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ButtonWidget(
                  onPress: () {
                    Navigator.pushReplacementNamed(context, '/search');
                  },
                  label: "Search Nearby Restaurants"),
            )
          ],
        ),
      ),
    );
  }
}
