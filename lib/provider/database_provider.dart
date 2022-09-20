import 'package:crestaurant2/database/database_helper.dart';
import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/provider/detail_restaurant_provider.dart';
import 'package:flutter/cupertino.dart';

class DatabaseProvider with ChangeNotifier {
  late DatabaseHelper databaseHelper = DatabaseHelper();

  late bool _isWish;
  late List<Restaurant> _wishList;
  late ResultState _state;

  bool get isWishValue => _isWish;

  List<Restaurant> get wishList => _wishList;

  ResultState get state => _state;

  DatabaseProvider() {
    getWishList();
  }

  void getWishList() async {
    try {
      _state = ResultState.loading;
      List<Restaurant> data = await databaseHelper.getWishList();
      if (data.isNotEmpty) {
        _wishList = data;
        _state = ResultState.hasData;
        notifyListeners();
      } else {
        _state = ResultState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }
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
    _state = ResultState.loading;
    final isExist = await databaseHelper.findById(id);
    bool val = isExist.isNotEmpty;
    _isWish = val;
    _state = ResultState.hasData;
    notifyListeners();
    return val;
  }

  Future<void> destroy(String id) async {
    try {
      _state = ResultState.loading;
      await databaseHelper.destroy(id);
      _isWish = false;
      getWishList();
      _state = ResultState.hasData;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }
  }
}
