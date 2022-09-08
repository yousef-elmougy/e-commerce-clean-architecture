
class AddUpdateDeleteAddressModel {
  AddUpdateDeleteAddressModel({
    this.status,
    this.message,
    this.data,
  });

  final bool? status;
  final String? message;
  final Data ?data;

  factory AddUpdateDeleteAddressModel.fromJson(Map<String, dynamic> json) => AddUpdateDeleteAddressModel(
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
    this.name,
    this.city,
    this.region,
    this.details,
    this.latitude,
    this.longitude,
    this.notes,
    this.id,
  });

  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final dynamic latitude;
  final dynamic longitude;
  final String? notes;
  final int ?id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    city: json["city"],
    region: json["region"],
    details: json["details"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    notes: json["notes"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "city": city,
    "region": region,
    "details": details,
    "latitude": latitude,
    "longitude": longitude,
    "notes": notes,
    "id": id,
  };
}
