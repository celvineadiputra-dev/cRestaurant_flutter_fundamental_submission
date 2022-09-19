import 'package:crestaurant2/database/database_helper.dart';
import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:flutter/cupertino.dart';

class DatabaseProvider with ChangeNotifier {
  late DatabaseHelper databaseHelper = DatabaseHelper();

  late bool _isWish;
  late List<Restaurant> _wishList;

  bool get isWishValue => _isWish;

  List<Restaurant> get wishList => _wishList;

  DatabaseProvider() {
    getWishList();
  }

  void getWishList() async {
    List<Restaurant> data = await databaseHelper.getWishList();
    _wishList = data;
    notifyListeners();
  }

  void addToWishList(Restaurant restaurant) async {
    try {
      await databaseHelper.insertData(restaurant);

      getWishList();
      _isWish = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isWish(String id) async {
    final isExist = await databaseHelper.findById(id);
    bool val = isExist.isNotEmpty;
    _isWish = val;
    notifyListeners();
    return val;
  }

  Future<void> destroy(String id) async {
    try {
      await databaseHelper.destroy(id);
      _isWish = false;
      getWishList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
