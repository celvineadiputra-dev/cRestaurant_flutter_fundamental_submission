import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/services/restaurant_service.dart';
import 'package:crestaurant2/utils/connection_check_manual_util.dart';
import 'package:flutter/foundation.dart';

enum ResultState {
  defaultState,
  loading,
  noData,
  hasData,
  error,
  connectionError
}

class SearchRestaurantProvider with ChangeNotifier {
  late ResultState _state;
  late List<Restaurant> _searchResult;

  ResultState get state => _state;

  List<Restaurant> get searchResult => _searchResult;

  Future<dynamic> searchRestaurant({required String value}) async {
    try {
      _state = ResultState.loading;

      if (await ConnectionCheckManual().isOffline()) {
        _state = ResultState.connectionError;
        notifyListeners();
        return;
      }

      List<Restaurant> data =
          await RestaurantService().findRestaurant(value: value);

      if (data.isNotEmpty) {
        _state = ResultState.hasData;

        _searchResult = data;

        notifyListeners();

        return data;
      } else {
        notifyListeners();
        _state = ResultState.noData;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return "Something is bad";
    }
  }

  void setLoading() {
    _state = ResultState.loading;
  }

  void setDefaultState() {
    _state = ResultState.defaultState;
  }
}
