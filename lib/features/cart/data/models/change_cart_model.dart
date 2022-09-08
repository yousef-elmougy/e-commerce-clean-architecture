// To parse this JSON data, do
//
//     final changeCartModel = changeCartModelFromJson(jsonString);

import 'dart:convert';

ChangeCartModel changeCartModelFromJson(String str) =>
    ChangeCartModel.fromJson(json.decode(str));

String changeCartModelToJson(ChangeCartModel data) =>
    json.encode(data.toJson());

class ChangeCartModel {
  ChangeCartModel({
    this.status,
    this.message,
    this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory ChangeCartModel.fromJson(Map<String, dynamic> json) =>
      ChangeCartModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.quantity,
    this.product,
  });

  final int? id;
  final int? quantity;
  final ChangeCartProduct? product;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        quantity: json["quantity"],
        product: json["product"] == null
            ? null
            : ChangeCartProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product?.toJson(),
      };
}

class ChangeCartProduct {
  ChangeCartProduct({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });

  final int? id;
  final double? price;
  final double? oldPrice;
  final int? discount;
  final String? image;
  final String? name;
  final String? description;

  factory ChangeCartProduct.fromJson(Map<String, dynamic> json) =>
      ChangeCartProduct(
        id: json["id"],
        price: json["price"].toDouble(),
        oldPrice: json["old_price"].toDouble(),
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
        "name": name,
        "description": description,
      };
}
