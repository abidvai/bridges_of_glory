import 'dart:convert';

BookListModel bookListModelFromJson(String str) =>
    BookListModel.fromJson(json.decode(str));

class BookListModel {
  final int count;
  final List<Book> data;

  BookListModel({
    required this.count,
    required this.data,
  });

  factory BookListModel.fromJson(Map<String, dynamic> json) {
    return BookListModel(
      count: json['count'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((e) => Book.fromJson(e))
          .toList(),
    );
  }
}

class Book {
  final int id;
  final String name;
  final String cover;
  final List<String> languages;
  final Map<String, String> pdfs;

  Book({
    required this.id,
    required this.name,
    required this.cover,
    required this.languages,
    required this.pdfs,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      cover: json['cover'] ?? '',
      languages: (json['languages'] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      pdfs: (json['pdfs'] as Map?)
          ?.map((k, v) =>
          MapEntry(k.toString(), v.toString())) ??
          {},
    );
  }

  /// 🔥 dynamic language support
  String? pdfByLanguage(String lang) => pdfs[lang];

  /// 🔁 fallback
  String? get anyPdf =>
      pdfs.isNotEmpty ? pdfs.values.first : null;
}
