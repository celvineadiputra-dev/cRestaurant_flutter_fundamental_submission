import 'dart:convert';

import 'package:crestaurant2/models/customer_review_model.dart';
import 'package:crestaurant2/services/restaurant_service.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  Future<List<CustomerReview>?> postReview(
      {required String id,
      required String name,
      required String review}) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> data = {'id': id, 'name': name, 'review': review};

      http.Response response = await http.post(
          Uri.parse("${RestaurantService.baseUrl}/review"),
          headers: headers,
          body: json.encode(data));

      List<CustomerReview> customerReview = [];
      if (response.statusCode == 201) {
        final data = json.decode(response.body);

        data['customerReviews'].map((item) {
          print(item);
          CustomerReview itemCustomerReview = CustomerReview.fromMap(item);
          customerReview.add(itemCustomerReview);
        }).toList();
      }
      return customerReview;
    } catch (e) {
      throw Exception(e);
    }
  }
}
