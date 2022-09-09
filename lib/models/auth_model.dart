import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel(
      {required this.userName, required this.email, required this.password});

  final String userName;
  final String email;
  final String password;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "password": password,
      };
}
