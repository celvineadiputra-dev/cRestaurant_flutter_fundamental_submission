import 'dart:convert';
import 'dart:math';

import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:flutter/cupertino.dart';

class RestaurantService {
  Future<List<Restaurant>> randomRestaurant(BuildContext context) async {
    try {
      final String response = await DefaultAssetBundle.of(context)
          .loadString("assets/data/local_restaurant.json");

      final data = json.decode(response);
      List<Restaurant> listRestaurant = [];

      List<int> listNumber = [];
      Random random = Random();
      for (var i = 0; i < 4; i++) {
        int randomNumber = random.nextInt(data['restaurants'].length);
        if (!listNumber.contains(randomNumber)) {
          Restaurant model =
              Restaurant.fromMap(data['restaurants'][randomNumber]);
          listRestaurant.add(model);
          listNumber.add(randomNumber);
        }
      }

      return listRestaurant;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Restaurant>> getPopularRestaurant(BuildContext context) async {
    try {
      final String response = await DefaultAssetBundle.of(context)
          .loadString("assets/data/local_restaurant.json");

      final data = json.decode(response);
      List<Restaurant> listRestaurant = [];

      for (var i = 0; i < 5; i++) {
        Restaurant model = Restaurant.fromMap(data['restaurants'][i]);
        listRestaurant.add(model);
      }

      return listRestaurant;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Restaurant>> getHottestRestaurant(BuildContext context) async {
    try {
      final String response = await DefaultAssetBundle.of(context)
          .loadString("assets/data/local_restaurant.json");

      final data = json.decode(response);
      List<Restaurant> listRestaurant = [];

      for (var i = 5; i < data['restaurants'].length; i++) {
        Restaurant model = Restaurant.fromMap(data['restaurants'][i]);
        listRestaurant.add(model);
      }

      return listRestaurant;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Restaurant>?> findRestaurant(
      {required BuildContext context, required String value}) async {
    try {
      final String response = await DefaultAssetBundle.of(context)
          .loadString("assets/data/local_restaurant.json");

      final data = json.decode(response);
      List<Restaurant> listRestaurant = [];

      if (!value.isNotEmpty) {
        return listRestaurant;
      }

      data['restaurants'].map((item) {
        Restaurant model = Restaurant.fromMap(item);
        listRestaurant.add(model);
      }).toList();

      List<Restaurant> result = listRestaurant.isNotEmpty
          ? listRestaurant.where((element) {
              return element.name.toLowerCase().contains(value.toLowerCase());
            }).toList()
          : [];

      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
