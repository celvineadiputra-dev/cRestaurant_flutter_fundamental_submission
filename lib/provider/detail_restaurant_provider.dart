import 'package:flutter/foundation.dart';
import 'package:crestaurant2/models/detail_restaurant_model.dart';
import 'package:crestaurant2/services/detail_restaurant_service.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestaurantProvider with ChangeNotifier {
  late ResultState _state;
  late DetailRestaurant? _detailRestaurant;

  DetailRestaurant? get detailRestaurant => _detailRestaurant;

  ResultState get state => _state;

  Future<dynamic> fetchDetail({required String id}) async {
    try {
      _state = ResultState.loading;
      DetailRestaurant? data =
          await DetailRestaurantService().fetchDetail(id: id);

      if (data != null) {
        _state = ResultState.hasData;

        _detailRestaurant = data;

        notifyListeners();

        return data;
      } else {
        notifyListeners();
        _state = ResultState.noData;
      }
    } catch (e) {
      print(e);
      _state = ResultState.error;
      notifyListeners();
      return "Something is bad";
    }
  }
}
