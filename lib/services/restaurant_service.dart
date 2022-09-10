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

      List<Restaurant> result = [];

      listRestaurant.map((item) {
        final String search = value.toLowerCase();
        if (item.name.toLowerCase() == search) {
          result.add(item);
        }
        item.menus.foods.map((food) {
          if (food.name.toLowerCase() == search) {
            result.add(item);
          }
        }).toList();

        item.menus.drinks.map((drink) {
          if (drink.name.toLowerCase() == search) {
            result.add(item);
          }
        }).toList();
      }).toList();

      return Future.delayed(Duration(seconds: 2), () {
        return result;
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
