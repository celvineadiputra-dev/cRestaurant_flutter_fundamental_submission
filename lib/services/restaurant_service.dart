import 'dart:convert';
import 'dart:math';

import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  static const String baseUrl = "https://restaurant-api.dicoding.dev";

  Future<List<Restaurant>> fetchData() async {
    try {
      List<Restaurant> listRestaurant = [];
      final response = await http.get(Uri.parse("$baseUrl/list"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        data['restaurants'].map((item) {
          Restaurant model = Restaurant.fromMap(item);
          listRestaurant.add(model);
        }).toList();
      }
      return listRestaurant;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Restaurant>> randomRestaurant(
      {required List<Restaurant> listRestaurant}) async {
    try {
      List<int> listNumber = [];
      Random random = Random();

      List<Restaurant> randomRestaurant = [];

      for (var i = 0; i < 4; i++) {
        int randomNumber = random.nextInt(listRestaurant.length);
        if (!listNumber.contains(randomNumber)) {
          randomRestaurant.add(listRestaurant[randomNumber]);
          listNumber.add(randomNumber);
        }
      }

      return randomRestaurant;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Restaurant>> getPopularRestaurant(
      {required List<Restaurant> listRestaurant}) async {
    try {
      List<Restaurant> listRestaurantPopular = [];

      if (listRestaurant.isNotEmpty) {
        listRestaurant.sort((a, b) => a.rating.compareTo(b.rating));
      }

      for (int index = listRestaurant.length - 5;
          index < listRestaurant.length;
          index++) {
        listRestaurantPopular.add(listRestaurant[index]);
      }

      return listRestaurantPopular.reversed.toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Restaurant>> getHottestRestaurant(
      {required List<Restaurant> listRestaurant}) async {
    try {
      List<Restaurant> listRestaurantHottest = [];

      if (listRestaurant.isNotEmpty) {
        listRestaurant.sort((a, b) => a.rating.compareTo(b.rating));
      }

      for (int index = 0; index < listRestaurant.length - 5; index++) {
        listRestaurantHottest.add(listRestaurant[index]);
      }

      return listRestaurantHottest;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Restaurant>> findRestaurant({required String value}) async {
    try {
      List<Restaurant> listRestaurant = [];

      final response = await http.get(Uri.parse("$baseUrl/search?q=$value"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        data['restaurants'].map((item) {
          Restaurant data = Restaurant.fromMap(item);
          listRestaurant.add(data);
        }).toList();
      }

      return listRestaurant;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Restaurant> fetchRandomOne() async {
    try {
      print("FETCH DATA RANDOMG ONE");
      List<Restaurant> listRestaurant = [];
      final response = await http.get(Uri.parse("$baseUrl/list"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        data['restaurants'].map((item) {
          Restaurant model = Restaurant.fromMap(item);
          listRestaurant.add(model);
        }).toList();
      }

      Random random = Random();
      int randomNumber = random.nextInt(listRestaurant.length);
      return listRestaurant[randomNumber];
    } catch (e) {
      throw Exception(e);
    }
  }
}
