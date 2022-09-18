import 'package:crestaurant2/provider/language_provider.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageWidget extends StatelessWidget {
  final Widget widget;
  const LanguageWidget({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<LanguageProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .selectYourLanguage,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    InkWell(
                        onTap: () {
                          language
                              .setLanguage("en");
                        },
                        child: const LanguageSelection(
                          country: "English",
                        )),
                    const Spacer(
                      flex: 1,
                    ),
                    InkWell(
                      onTap: () {
                        language.setLanguage("id");
                      },
                      child: const LanguageSelection(
                        country: "Indonesia",
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      child: widget,
    );
  }
}
class LanguageSelection extends StatelessWidget {
  final String country;

  const LanguageSelection({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 100,
      decoration:
      BoxDecoration(color: grey3, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(globe),
          const SizedBox(
            height: 10,
          ),
          Text(country)
        ],
      ),
    );
  }
}