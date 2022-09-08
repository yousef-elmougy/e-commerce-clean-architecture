// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.status,
    this.message,
    this.data,
  });

  final bool? status;
  final dynamic message;
  final Data? data;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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
    this.cartItems,
    this.subTotal,
    this.total,
  });

  final List<CartItem>? cartItems;
  final double? subTotal;
  final double? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cartItems: json["cart_items"] == null
            ? null
            : List<CartItem>.from(
                json["cart_items"].map((x) => CartItem.fromJson(x))),
        subTotal: json["sub_total"].toDouble(),
        total: json["total"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "cart_items": cartItems == null
            ? null
            : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
        "sub_total": subTotal,
        "total": total,
      };
}

class CartItem {
  CartItem({
    this.id,
    this.quantity,
    this.product,
  });

  final int? id;
  final int? quantity;
  final CartProduct? product;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        quantity: json["quantity"],
        product: json["product"] == null
            ? null
            : CartProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product?.toJson(),
      };
}

class CartProduct {
  CartProduct({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  final int? id;
  final double? price;
  final double? oldPrice;
  final int? discount;
  final String? image;
  final String? name;
  final String? description;
  final List<String>? images;
  final bool? inFavorites;
  final bool? inCart;

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json["id"],
        price: json["price"].toDouble(),
        oldPrice: json["old_price"].toDouble(),
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        inFavorites: json["in_favorites"],
        inCart: json["in_cart"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
        "name": name,
        "description": description,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "in_favorites": inFavorites,
        "in_cart": inCart,
      };
}
