import 'dart:convert';

import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/services/restaurant_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'restaurant_parsing_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("Test parsing json from api to restaurant model", () {
    const mockData = {
      "restaurants": [
        {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description": "Quisque rutrum. Aenean imperdiet.",
          "pictureId": "25",
          "city": "Gorontalo",
          "rating": 4
        }
      ]
    };

    test("get list restaurant", () async {
      final client = MockClient();

      when(client.get(Uri.parse("https://restaurant-api.dicoding.dev/list")))
          .thenAnswer((_) async => http.Response(jsonEncode(mockData), 200));

      expect(await RestaurantService().fetchData(), isA<List<Restaurant>>());
    });
  });
}
