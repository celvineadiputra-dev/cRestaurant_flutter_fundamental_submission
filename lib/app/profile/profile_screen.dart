import 'package:crestaurant2/app/widgets/language_widget.dart';
import 'package:crestaurant2/provider/auth_provider.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: grey1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.currentUser.userName,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: dark, fontSize: 15),
                      ),
                      Text(authProvider.currentUser.email)
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Accounts",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: dark),
              ),
              const SizedBox(
                height: 20,
              ),
              const Tile(icon: like, label: "My Favorite Restaurant"),
              const LanguageWidget(widget: Tile(icon: globe, label: "Change Language")),
              const Tile(icon: promotion, label: "Promotion"),
              const Tile(icon: help, label: "Help"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Logout",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.pink, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final String icon, label;

  const Tile({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon),
              const SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: dark, fontSize: 14),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: grey1,
            size: 16,
          )
        ],
      ),
    );
  }
}
