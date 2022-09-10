import 'dart:convert';

class Drink {
  Drink({
    required this.name,
  });

  final String name;

  factory Drink.fromJson(String str) => Drink.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Drink.fromMap(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
