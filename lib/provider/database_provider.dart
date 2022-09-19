import 'package:crestaurant2/database/database_helper.dart';
import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:flutter/cupertino.dart';

class DatabaseProvider with ChangeNotifier {
  late DatabaseHelper databaseHelper = DatabaseHelper();

  late bool _isWish;

  bool get isWishValue => _isWish;

  void getWishList() async {
    List<Restaurant> data = await databaseHelper.getWishList();
    print(data[1].name);
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
    return val;
  }
}
