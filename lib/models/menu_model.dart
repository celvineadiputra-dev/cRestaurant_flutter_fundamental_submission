import 'dart:convert';

import 'item_menu_model.dart';

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  final List<ItemMenuModel> foods;
  final List<ItemMenuModel> drinks;

  factory Menus.fromJson(String str) => Menus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Menus.fromMap(Map<String, dynamic> json) => Menus(
        foods: List<ItemMenuModel>.from(json["foods"].map((x) => ItemMenuModel.fromMap(x))),
        drinks: List<ItemMenuModel>.from(json["drinks"].map((x) => ItemMenuModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toMap())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toMap())),
      };
}
