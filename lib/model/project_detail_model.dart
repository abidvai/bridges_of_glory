
class ProjectDetailsModel {
  int id;
  String title;
  Category program;
  Category category;
  String coverImage;
  String village;
  String location;
  String pastorName;
  String sponsorName;
  DateTime establishedDate;
  String projectDetails;
  String recentUpdates;
  String projectStories;
  int totalBenefitedFamilies;
  String impact;
  String status;
  int viewsCount;
  DateTime createdAt;
  DateTime updatedAt;
  List<OtherSupport> pastorSupportPrices;
  List<LivestockItem> livestockItems;
  List<OtherSupport> otherSupports;

  ProjectDetailsModel({
    required this.id,
    required this.title,
    required this.program,
    required this.category,
    required this.coverImage,
    required this.village,
    required this.location,
    required this.pastorName,
    required this.sponsorName,
    required this.establishedDate,
    required this.projectDetails,
    required this.recentUpdates,
    required this.projectStories,
    required this.totalBenefitedFamilies,
    required this.impact,
    required this.status,
    required this.viewsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.pastorSupportPrices,
    required this.livestockItems,
    required this.otherSupports,
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
    int? viewsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OtherSupport>? pastorSupportPrices,
    List<LivestockItem>? livestockItems,
    List<OtherSupport>? otherSupports,
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
        viewsCount: viewsCount ?? this.viewsCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pastorSupportPrices: pastorSupportPrices ?? this.pastorSupportPrices,
        livestockItems: livestockItems ?? this.livestockItems,
        otherSupports: otherSupports ?? this.otherSupports,
      );

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) => ProjectDetailsModel(
    id: json["id"],
    title: json["title"],
    program: Category.fromJson(json["program"]),
    category: Category.fromJson(json["category"]),
    coverImage: json["cover_image"],
    village: json["village"],
    location: json["location"],
    pastorName: json["pastor_name"],
    sponsorName: json["sponsor_name"],
    establishedDate: DateTime.parse(json["established_date"]),
    projectDetails: json["project_details"],
    recentUpdates: json["recent_updates"],
    projectStories: json["project_stories"],
    totalBenefitedFamilies: json["total_benefited_families"],
    impact: json["impact"],
    status: json["status"],
    viewsCount: json["views_count"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pastorSupportPrices: List<OtherSupport>.from(json["pastor_support_prices"].map((x) => OtherSupport.fromJson(x))),
    livestockItems: List<LivestockItem>.from(json["livestock_items"].map((x) => LivestockItem.fromJson(x))),
    otherSupports: List<OtherSupport>.from(json["other_supports"].map((x) => OtherSupport.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "program": program.toJson(),
    "category": category.toJson(),
    "cover_image": coverImage,
    "village": village,
    "location": location,
    "pastor_name": pastorName,
    "sponsor_name": sponsorName,
    "established_date": "${establishedDate.year.toString().padLeft(4, '0')}-${establishedDate.month.toString().padLeft(2, '0')}-${establishedDate.day.toString().padLeft(2, '0')}",
    "project_details": projectDetails,
    "recent_updates": recentUpdates,
    "project_stories": projectStories,
    "total_benefited_families": totalBenefitedFamilies,
    "impact": impact,
    "status": status,
    "views_count": viewsCount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pastor_support_prices": List<dynamic>.from(pastorSupportPrices.map((x) => x.toJson())),
    "livestock_items": List<dynamic>.from(livestockItems.map((x) => x.toJson())),
    "other_supports": List<dynamic>.from(otherSupports.map((x) => x.toJson())),
  };
}

class Category {
  int id;
  String name;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
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
  int id;
  String name;
  int quantity;
  String amount;
  String currency;

  LivestockItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.amount,
    required this.currency,
  });

  LivestockItem copyWith({
    int? id,
    String? name,
    int? quantity,
    String? amount,
    String? currency,
  }) =>
      LivestockItem(
        id: id ?? this.id,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
      );

  factory LivestockItem.fromJson(Map<String, dynamic> json) => LivestockItem(
    id: json["id"],
    name: json["name"],
    quantity: json["quantity"],
    amount: json["amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "quantity": quantity,
    "amount": amount,
    "currency": currency,
  };
}

class OtherSupport {
  int id;
  String amount;
  String currency;

  OtherSupport({
    required this.id,
    required this.amount,
    required this.currency,
  });

  OtherSupport copyWith({
    int? id,
    String? amount,
    String? currency,
  }) =>
      OtherSupport(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
      );

  factory OtherSupport.fromJson(Map<String, dynamic> json) => OtherSupport(
    id: json["id"],
    amount: json["amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "currency": currency,
  };
}
