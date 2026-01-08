import 'package:get/get.dart';

import '../utils/enum/explore_type.dart';

class ExploreDetailsModel {
  int? id;
  String? image;
  String? name;
  String? title;
  String? information;
  String? description;
  ExploreType? type;
  String? link;
  String? createdAt;

  ExploreDetailsModel({
    this.id,
    this.image,
    this.name,
    this.title,
    this.information,
    this.description,
    this.type,
    this.link,
    this.createdAt,
  });

  factory ExploreDetailsModel.fromJson(Map<String, dynamic> json) =>
      ExploreDetailsModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        title: json["title"],
        information: json["information"],
        description: json["description"],
        type: _parseExploreType(json["type"]),
        link: json["link"],
        createdAt: json["created_at"],
      );

  static ExploreType? _parseExploreType(String? value) {
    if (value == null) return null;

    return ExploreType.values.firstWhereOrNull(
          (e) => e.name == value,
    );
  }
}
