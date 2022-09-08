// To parse this JSON data, do
//
//     final updateCartModel = updateCartModelFromJson(jsonString);

import 'dart:convert';

UpdateCartModel updateCartModelFromJson(String str) =>
    UpdateCartModel.fromJson(json.decode(str));

String updateCartModelToJson(UpdateCartModel data) =>
    json.encode(data.toJson());

class UpdateCartModel {
  UpdateCartModel({
    this.status,
    this.message,
    this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory UpdateCartModel.fromJson(Map<String, dynamic> json) =>
      UpdateCartModel(
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
    this.cart,
    this.subTotal,
    this.total,
  });

  final Cart? cart;
  final int? subTotal;
  final int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
        subTotal: json["sub_total"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "cart": cart?.toJson(),
        "sub_total": subTotal,
        "total": total,
      };
}

class Cart {
  Cart({
    this.id,
    this.quantity,
    this.product,
  });

  final int? id;
  final dynamic quantity;
  final Product? product;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        quantity: json["quantity"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product?.toJson(),
      };
}

class Product {
  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
  });

  final int? id;
  final int? price;
  final int? oldPrice;
  final int? discount;
  final String? image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
        oldPrice: json["old_price"],
        discount: json["discount"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
      };
}
