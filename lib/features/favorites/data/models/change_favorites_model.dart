
class ChangeFavoritesModel {
  ChangeFavoritesModel({
    this.status,
    this.message,
    this.data,
  });

  final bool? status;
  final String? message;
  final Data ?data;

  factory ChangeFavoritesModel.fromJson(Map<String, dynamic> json) => ChangeFavoritesModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data":  data?.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.product,
  });

  final int ?id;
  final Product? product;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
  final dynamic price;
  final dynamic oldPrice;
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
