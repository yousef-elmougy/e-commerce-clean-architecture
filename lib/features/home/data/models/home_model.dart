class HomeModel {
  HomeModel({
    this.status,
    this.message,
    this.data,
  });

  final bool? status;
  final dynamic message;
  final Data? data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        message: json["message"],
        data:
            // json["data"] ??
            Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data ?? data?.toJson(),
      };
}

class Data {
  Data({
    this.banners,
    this.products,
    this.ad,
  });

  final List<Banner>? banners;
  final List<HomeProduct>? products;
  final String? ad;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banners:
            // json["banners"] ??
            List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
        products:
            // json["products"] ??
            List<HomeProduct>.from(
                json["products"].map((x) => HomeProduct.fromJson(x))),
        ad: json["ad"],
      );

  Map<String, dynamic> toJson() => {
        "banners":
            // banners ??
            List<dynamic>.from(banners!.map((x) => x.toJson())),
        "products":
            // products ??
            List<dynamic>.from(products!.map((x) => x.toJson())),
        "ad": ad,
      };
}

class Banner {
  Banner({
    this.id,
    this.image,
    this.category,
    this.product,
  });

  final int? id;
  final String? image;
  final dynamic category;
  final dynamic product;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["id"],
        image: json["image"],
        category: json["category"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "category": category,
        "product": product,
      };
}

class HomeProduct {
  HomeProduct({
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

  factory HomeProduct.fromJson(Map<String, dynamic> json) => HomeProduct(
        id: json["id"],
        price:
            // json["price"] ??
            json["price"].toDouble(),
        oldPrice:
            // json["old_price"] ??
            json["old_price"].toDouble(),
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        images:
            // json["images"] ??
            List<String>.from(json["images"].map((x) => x)),
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
            // images ??
            List<dynamic>.from(images!.map((x) => x)),
        "in_favorites": inFavorites,
        "in_cart": inCart,
      };
}
