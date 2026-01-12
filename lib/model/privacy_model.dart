import 'dart:convert';

class PrivacyModel {
  int? id;
  String? title;
  String? description;

  PrivacyModel({
    this.id,
    this.title,
    this.description,
  });

  PrivacyModel copyWith({
    int? id,
    String? title,
    String? description,
  }) =>
      PrivacyModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory PrivacyModel.fromRawJson(String str) => PrivacyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
  };
}
