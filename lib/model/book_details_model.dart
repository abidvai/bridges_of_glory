
import 'dart:convert';

class BookDetailsModel {
  int id;
  String name;
  String cover;
  List<String> languages;
  Pdfs pdfs;

  BookDetailsModel({
    required this.id,
    required this.name,
    required this.cover,
    required this.languages,
    required this.pdfs,
  });

  BookDetailsModel copyWith({
    int? id,
    String? name,
    String? cover,
    List<String>? languages,
    Pdfs? pdfs,
  }) =>
      BookDetailsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        cover: cover ?? this.cover,
        languages: languages ?? this.languages,
        pdfs: pdfs ?? this.pdfs,
      );

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) => BookDetailsModel(
    id: json["id"],
    name: json["name"],
    cover: json["cover"],
    languages: List<String>.from(json["languages"].map((x) => x)),
    pdfs: Pdfs.fromJson(json["pdfs"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cover": cover,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "pdfs": pdfs.toJson(),
  };
}

class Pdfs {
  String en;

  Pdfs({
    required this.en,
  });

  Pdfs copyWith({
    String? en,
  }) =>
      Pdfs(
        en: en ?? this.en,
      );

  factory Pdfs.fromJson(Map<String, dynamic> json) => Pdfs(
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
  };
}
