import 'dart:convert';

import 'drink_model.dart';
import 'food_model.dart';

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  final List<Food> foods;
  final List<Drink> drinks;

  factory Menus.fromJson(String str) => Menus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Menus.fromMap(Map<String, dynamic> json) => Menus(
        foods: List<Food>.from(json["foods"].map((x) => Food.fromMap(x))),
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toMap())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toMap())),
      };
}
