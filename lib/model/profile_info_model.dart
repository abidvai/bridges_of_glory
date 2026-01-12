import 'dart:convert';

class ProfileInfoModel {
  String? message;
  Data? data;

  ProfileInfoModel({
    this.message,
    this.data,
  });

  ProfileInfoModel copyWith({
    String? message,
    Data? data,
  }) =>
      ProfileInfoModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ProfileInfoModel.fromRawJson(String str) => ProfileInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) => ProfileInfoModel(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? fullName;
  String? email;
  String? avatar;
  String? role;

  Data({
    this.id,
    this.fullName,
    this.email,
    this.avatar,
    this.role,
  });

  Data copyWith({
    String? id,
    String? fullName,
    String? email,
    String? avatar,
    String? role,
  }) =>
      Data(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        role: role ?? this.role,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullName: json["full_name"],
    email: json["email"],
    avatar: json["avatar"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "email": email,
    "avatar": avatar,
    "role": role,
  };
}
