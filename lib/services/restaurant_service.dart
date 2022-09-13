import 'dart:convert';
import 'dart:math';

import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:http/http.dart' as http;

class RestaurantService {
  final String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<List<Restaurant>> fetchData() async {
    print("FETCH");
    try {
      List<Restaurant> listRestaurant = [];
      final response = await http.get(Uri.parse("$_baseUrl/list"));

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

  Future<List<Restaurant>> randomRestaurant({required List<Restaurant> listRestaurant}) async {
    try {
      // List<Restaurant> listRestaurant = await fetchData();

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

  Future<List<Restaurant>> getPopularRestaurant({required List<Restaurant> listRestaurant}) async {
    try {
      // List<Restaurant> listRestaurant = await fetchData();

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

  Future<List<Restaurant>> getHottestRestaurant({required List<Restaurant> listRestaurant}) async {
    try {
      // List<Restaurant> listRestaurant = await fetchData();

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

// Future<List<Restaurant>?> findRestaurant(
//     {required , required String value}) async {
//   try {
//     final String response = await DefaultAssetBundle.of(context)
//         .loadString("assets/data/local_restaurant.json");
//
//     final data = json.decode(response);
//     List<Restaurant> listRestaurant = [];
//
//     if (!value.isNotEmpty) {
//       return listRestaurant;
//     }
//
//     data['restaurants'].map((item) {
//       Restaurant model = Restaurant.fromMap(item);
//       listRestaurant.add(model);
//     }).toList();
//
//     List<Restaurant> result = [];
//
//     listRestaurant.map((item) {
//       final String search = value.toLowerCase();
//       if (item.name.toLowerCase() == search) {
//         result.add(item);
//       }
//       item.menus.foods.map((food) {
//         if (food.name.toLowerCase() == search) {
//           result.add(item);
//         }
//       }).toList();
//
//       item.menus.drinks.map((drink) {
//         if (drink.name.toLowerCase() == search) {
//           result.add(item);
//         }
//       }).toList();
//     }).toList();
//
//     return Future.delayed(Duration(seconds: 2), () {
//       return result;
//     });
//   } catch (e) {
//     throw Exception(e);
//   }
// }
}
