
class UserModel {
  UserModel({
    this.status,
    this.message,
    this.data,
  });

  final bool? status;
  final String? message;
  final Data ?data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final int? points;
  final int? credit;
  final String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    points: json["points"],
    credit: json["credit"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "points": points,
    "credit": credit,
    "token": token,
  };
}
