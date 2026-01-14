
import 'dart:convert';

BookListModel bookListModelFromJson(String str) => BookListModel.fromJson(json.decode(str));

String bookListModelToJson(BookListModel data) => json.encode(data.toJson());

class BookListModel {
  int count;
  List<Datum> data;

  BookListModel({
    required this.count,
    required this.data,
  });

  BookListModel copyWith({
    int? count,
    List<Datum>? data,
  }) =>
      BookListModel(
        count: count ?? this.count,
        data: data ?? this.data,
      );

  factory BookListModel.fromJson(Map<String, dynamic> json) => BookListModel(
    count: json["count"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String name;
  String cover;
  List<String> languages;
  Pdfs pdfs;

  Datum({
    required this.id,
    required this.name,
    required this.cover,
    required this.languages,
    required this.pdfs,
  });

  Datum copyWith({
    int? id,
    String? name,
    String? cover,
    List<String>? languages,
    Pdfs? pdfs,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        cover: cover ?? this.cover,
        languages: languages ?? this.languages,
        pdfs: pdfs ?? this.pdfs,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
  String? bn;
  String en;

  Pdfs({
    this.bn,
    required this.en,
  });

  Pdfs copyWith({
    String? bn,
    String? en,
  }) =>
      Pdfs(
        bn: bn ?? this.bn,
        en: en ?? this.en,
      );

  factory Pdfs.fromJson(Map<String, dynamic> json) => Pdfs(
    bn: json["bn"],
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "bn": bn,
    "en": en,
  };

  operator [](String other) {}
}
