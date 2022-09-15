import 'package:crestaurant2/models/customer_review_model.dart';
import 'package:crestaurant2/utils/connection_check_manual_util.dart';
import 'package:flutter/foundation.dart';
import 'package:crestaurant2/models/detail_restaurant_model.dart';
import 'package:crestaurant2/services/detail_restaurant_service.dart';

enum ResultState { loading, noData, hasData, error, connectionError }

class DetailRestaurantProvider with ChangeNotifier {
  late ResultState _state;
  late DetailRestaurant? _detailRestaurant;

  DetailRestaurant? get detailRestaurant => _detailRestaurant;

  ResultState get state => _state;

  Future<dynamic> fetchDetail({required String id}) async {
    try {
      _state = ResultState.loading;

      if (await ConnectionCheckManual().isOffline()) {
        _state = ResultState.connectionError;
        notifyListeners();
        return;
      }

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
      _state = ResultState.error;
      notifyListeners();
      return "Something is bad";
    }
  }

  void setNewReview({required List<CustomerReview>? newReview}) {
    print('-------------------3');
    print(newReview);
    print('-------------------3');
    _detailRestaurant!.customerReviews = newReview!;
    notifyListeners();
  }
}
