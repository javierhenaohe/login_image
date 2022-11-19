// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product({
    required this.available,
    required this.name,
    this.picture,
    required this.ubTecnica,
    this.id,
  });

  bool available;
  String name;
  String? picture;
  String?
      ubTecnica; //este de debe cambiar a string para anexar el formato PPTMXXOO, CAMBIAR NOMBRE DE ubTecnica a ubTecnica
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        ubTecnica: json["ubTecnica"], //.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "ubTecnica": ubTecnica,
      };

  Product copy() => Product(
        available: this.available,
        name: this.name,
        picture: this.picture,
        ubTecnica: this.ubTecnica,
        id: this.id,
      );
}
