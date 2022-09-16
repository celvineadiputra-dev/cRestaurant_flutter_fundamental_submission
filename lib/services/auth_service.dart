import 'dart:convert';

import 'package:crestaurant2/models/auth_model.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  Future<AuthModel> login(
      BuildContext context, String email, String password) async {
    try {
      final String response = await DefaultAssetBundle.of(context)
          .loadString("assets/data/local_auth.json");

      return Future.delayed(const Duration(seconds: 2), () {
        final data = json.decode(response);

        AuthModel authModel = AuthModel.fromJson(data);

        return authModel;
        // return authModel.email == email && authModel.password == password;
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
