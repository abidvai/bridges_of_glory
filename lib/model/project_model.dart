import 'dart:convert';

class ProjectModel {
  int? id;
  String? title;
  Category? program;
  Category? category;
  String? coverImage;
  String? village;
  String? location;
  int? totalBenefitedFamilies;
  String? status;

  ProjectModel({
    this.id,
    this.title,
    this.program,
    this.category,
    this.coverImage,
    this.village,
    this.location,
    this.totalBenefitedFamilies,
    this.status,
  });

  ProjectModel copyWith({
    int? id,
    String? title,
    Category? program,
    Category? category,
    String? coverImage,
    String? village,
    String? location,
    int? totalBenefitedFamilies,
    String? status,
  }) =>
      ProjectModel(
        id: id ?? this.id,
        title: title ?? this.title,
        program: program ?? this.program,
        category: category ?? this.category,
        coverImage: coverImage ?? this.coverImage,
        village: village ?? this.village,
        location: location ?? this.location,
        totalBenefitedFamilies: totalBenefitedFamilies ?? this.totalBenefitedFamilies,
        status: status ?? this.status,
      );

  factory ProjectModel.fromRawJson(String str) => ProjectModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json["id"],
    title: json["title"],
    program: json["program"] == null ? null : Category.fromJson(json["program"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    coverImage: json["cover_image"],
    village: json["village"],
    location: json["location"],
    totalBenefitedFamilies: json["total_benefited_families"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "program": program?.toJson(),
    "category": category?.toJson(),
    "cover_image": coverImage,
    "village": village,
    "location": location,
    "total_benefited_families": totalBenefitedFamilies,
    "status": status,
  };
}

class Category {
  int? id;
  String? name;
  String? image;

  Category({
    this.id,
    this.name,
    this.image,
  });

  Category copyWith({
    int? id,
    String? name,
    String? image,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
      );

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
