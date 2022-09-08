
class ChangePasswordModel {
  ChangePasswordModel({
    this.status,
    this.message,
    this.data,
  });

  final bool? status;
  final String? message;
  final Data ?data;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
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
    this.email,
  });

  final String? email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
