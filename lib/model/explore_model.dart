import 'dart:convert';

class ExploreModel {
  int? id;
  String? name;
  String? image;

  ExploreModel({
    this.id,
    this.name,
    this.image,
  });

  ExploreModel copyWith({
    int? id,
    String? name,
    String? image,
  }) =>
      ExploreModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
      );

  factory ExploreModel.fromRawJson(String str) => ExploreModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExploreModel.fromJson(Map<String, dynamic> json) => ExploreModel(
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
