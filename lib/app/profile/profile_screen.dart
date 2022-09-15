import 'package:crestaurant2/provider/auth_provider.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';
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
                      Text(authProvider.currentUser.userName, style: Theme.of(context).textTheme.headline6!.copyWith(color: dark, fontSize: 15),),
                      Text(authProvider.currentUser.email)
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text("Settings", style: Theme.of(context).textTheme.subtitle2!.copyWith(color: dark),),
              const ListTile(
                leading: Icon(Icons.language),
                title: Text("Change Language"),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
              ),
              const ListTile(
                leading: Icon(Icons.language),
                title: Text("Change Language"),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
              ),
              const ListTile(
                leading: Icon(Icons.language),
                title: Text("Change Language"),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
              ),
              const ListTile(
                leading: Icon(Icons.language),
                title: Text("Change Language"),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
              ),
              const ListTile(
                leading: Icon(Icons.language),
                title: Text("Change Language"),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}
