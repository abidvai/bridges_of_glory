import 'dart:convert';

class CategoryModel {
  int? id;
  String? name;
  String? image;

  CategoryModel({
    this.id,
    this.name,
    this.image,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    String? image,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
      );

  factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
