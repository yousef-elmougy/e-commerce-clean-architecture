
class AddressModel {
  AddressModel({
    this.status,
    this.message,
    this.data,
  });

  final bool? status;
  final dynamic message;
  final Data ?data;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final int? currentPage;
  final List<AddressData>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? null : List<AddressData>.from(json["data"].map((x) => AddressData.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class AddressData {
  AddressData({
    this.id,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
    this.latitude,
    this.longitude,
  });

  final int ?id;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;
  final double? latitude;
  final double? longitude;

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
    id: json["id"],
    name: json["name"],
    city: json["city"],
    region: json["region"],
    details: json["details"],
    notes: json["notes"],
    latitude:  json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city": city,
    "region": region,
    "details": details,
    "notes": notes,
    "latitude": latitude,
    "longitude": longitude,
  };
}
