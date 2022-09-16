import 'dart:convert';

import 'package:crestaurant2/models/detail_restaurant_model.dart';
import 'package:crestaurant2/services/restaurant_service.dart';
import 'package:http/http.dart' as http;

class DetailRestaurantService {
  Future<DetailRestaurant?> fetchDetail({required String id}) async {
    try {
      final response =
          await http.get(Uri.parse("${RestaurantService.baseUrl}/detail/$id"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        DetailRestaurant detailRestaurant =
            DetailRestaurant.fromMap(data['restaurant']);

        return detailRestaurant;
      }

      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
