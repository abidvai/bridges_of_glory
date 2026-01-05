import 'dart:convert';

class LoginModel {
  String? message;
  String? accessToken;
  String? refreshToken;
  String? userId;
  String? role;

  LoginModel({
    this.message,
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.role,
  });

  factory LoginModel.fromRawJson(String str) => LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    userId: json["user_id"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "user_id": userId,
    "role": role,
  };
}
