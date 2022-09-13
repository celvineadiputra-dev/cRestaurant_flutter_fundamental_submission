import 'package:crestaurant2/models/auth_model.dart';
import 'package:crestaurant2/services/auth_service.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  late AuthModel _currentUser;

  AuthModel get currentUser => _currentUser;

  Future<bool> register(BuildContext context, String userName, String email,
      String password) async {
    AuthModel fake = AuthModel.fromJson(
        {"userName": userName, "email": email, "password": password});

    _currentUser = fake;

    notifyListeners();

    return true;
  }

  Future<bool> login(
      BuildContext context, String email, String password) async {
    AuthModel fake = await AuthService().login(context, email, password);

    if (fake.email == email && fake.password == password) {
      _currentUser = fake;

      notifyListeners();

      return true;
    }

    notifyListeners();
    return false;
  }
}
