import 'dart:convert';

class ProjectDetailsModel {
  int? id;
  String? title;
  Category? program;
  Category? category;
  String? coverImage;
  String? village;
  String? location;
  String? pastorName;
  String? sponsorName;
  DateTime? establishedDate;
  String? projectDetails;
  String? recentUpdates;
  String? projectStories;
  int? totalBenefitedFamilies;
  String? impact;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<LivestockItem>? pastorSupportPrices;
  List<LivestockItem>? livestockItems;
  List<LivestockItem>? otherSupports;

  ProjectDetailsModel({
    this.id,
    this.title,
    this.program,
    this.category,
    this.coverImage,
    this.village,
    this.location,
    this.pastorName,
    this.sponsorName,
    this.establishedDate,
    this.projectDetails,
    this.recentUpdates,
    this.projectStories,
    this.totalBenefitedFamilies,
    this.impact,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pastorSupportPrices,
    this.livestockItems,
    this.otherSupports,
  });

  ProjectDetailsModel copyWith({
    int? id,
    String? title,
    Category? program,
    Category? category,
    String? coverImage,
    String? village,
    String? location,
    String? pastorName,
    String? sponsorName,
    DateTime? establishedDate,
    String? projectDetails,
    String? recentUpdates,
    String? projectStories,
    int? totalBenefitedFamilies,
    String? impact,
    String? status,
    String? createdAt,
    String? updatedAt,
    List<LivestockItem>? pastorSupportPrices,
    List<LivestockItem>? livestockItems,
    List<LivestockItem>? otherSupports,
  }) =>
      ProjectDetailsModel(
        id: id ?? this.id,
        title: title ?? this.title,
        program: program ?? this.program,
        category: category ?? this.category,
        coverImage: coverImage ?? this.coverImage,
        village: village ?? this.village,
        location: location ?? this.location,
        pastorName: pastorName ?? this.pastorName,
        sponsorName: sponsorName ?? this.sponsorName,
        establishedDate: establishedDate ?? this.establishedDate,
        projectDetails: projectDetails ?? this.projectDetails,
        recentUpdates: recentUpdates ?? this.recentUpdates,
        projectStories: projectStories ?? this.projectStories,
        totalBenefitedFamilies: totalBenefitedFamilies ?? this.totalBenefitedFamilies,
        impact: impact ?? this.impact,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pastorSupportPrices: pastorSupportPrices ?? this.pastorSupportPrices,
        livestockItems: livestockItems ?? this.livestockItems,
        otherSupports: otherSupports ?? this.otherSupports,
      );

  factory ProjectDetailsModel.fromRawJson(String str) => ProjectDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) => ProjectDetailsModel(
    id: json["id"],
    title: json["title"],
    program: json["program"] == null ? null : Category.fromJson(json["program"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    coverImage: json["cover_image"],
    village: json["village"],
    location: json["location"],
    pastorName: json["pastor_name"],
    sponsorName: json["sponsor_name"],
    establishedDate: json["established_date"] == null ? null : DateTime.parse(json["established_date"]),
    projectDetails: json["project_details"],
    recentUpdates: json["recent_updates"],
    projectStories: json["project_stories"],
    totalBenefitedFamilies: json["total_benefited_families"],
    impact: json["impact"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    pastorSupportPrices: json["pastor_support_prices"] == null ? [] : List<LivestockItem>.from(json["pastor_support_prices"]!.map((x) => LivestockItem.fromJson(x))),
    livestockItems: json["livestock_items"] == null ? [] : List<LivestockItem>.from(json["livestock_items"]!.map((x) => LivestockItem.fromJson(x))),
    otherSupports: json["other_supports"] == null ? [] : List<LivestockItem>.from(json["other_supports"]!.map((x) => LivestockItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "program": program?.toJson(),
    "category": category?.toJson(),
    "cover_image": coverImage,
    "village": village,
    "location": location,
    "pastor_name": pastorName,
    "sponsor_name": sponsorName,
    "established_date": "${establishedDate!.year.toString().padLeft(4, '0')}-${establishedDate!.month.toString().padLeft(2, '0')}-${establishedDate!.day.toString().padLeft(2, '0')}",
    "project_details": projectDetails,
    "recent_updates": recentUpdates,
    "project_stories": projectStories,
    "total_benefited_families": totalBenefitedFamilies,
    "impact": impact,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "pastor_support_prices": pastorSupportPrices == null ? [] : List<dynamic>.from(pastorSupportPrices!.map((x) => x.toJson())),
    "livestock_items": livestockItems == null ? [] : List<dynamic>.from(livestockItems!.map((x) => x.toJson())),
    "other_supports": otherSupports == null ? [] : List<dynamic>.from(otherSupports!.map((x) => x.toJson())),
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

class LivestockItem {
  int? id;
  String? name;

  LivestockItem({
    this.id,
    this.name,
  });

  LivestockItem copyWith({
    int? id,
    String? name,
  }) =>
      LivestockItem(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory LivestockItem.fromRawJson(String str) => LivestockItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LivestockItem.fromJson(Map<String, dynamic> json) => LivestockItem(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
