import 'dart:convert';

class ItemMenuModel {
  ItemMenuModel({
    required this.name,
  });

  final String name;

  factory ItemMenuModel.fromJson(String str) =>
      ItemMenuModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemMenuModel.fromMap(Map<String, dynamic> json) => ItemMenuModel(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
