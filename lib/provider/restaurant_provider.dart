import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/services/restaurant_service.dart';
import 'package:flutter/foundation.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider with ChangeNotifier {
  late ResultState _state;
  late List<Restaurant> _restaurant;
  late List<Restaurant> _suggestRestaurant;
  late List<Restaurant> _popularRestaurant;
  late List<Restaurant> _hottestRestaurant;

  List<Restaurant> get restaurant => _restaurant;

  List<Restaurant> get suggestRestaurant => _suggestRestaurant;

  List<Restaurant> get popularRestaurant => _popularRestaurant;

  List<Restaurant> get hottestRestaurant => _hottestRestaurant;


  ResultState get state => _state;

  RestaurantProvider() {
    fetchRestaurant();
  }

  Future<dynamic> fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      List<Restaurant> data = await RestaurantService().fetchData();

      if (data.isNotEmpty) {
        _state = ResultState.hasData;

        _suggestRestaurant =
            await RestaurantService().randomRestaurant(listRestaurant: data);

        _popularRestaurant = await RestaurantService()
            .getPopularRestaurant(listRestaurant: data);

        _hottestRestaurant = await RestaurantService()
            .getHottestRestaurant(listRestaurant: data);

        _restaurant = data;
        notifyListeners();

        return _restaurant;
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
}
