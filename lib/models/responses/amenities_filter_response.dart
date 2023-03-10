class AmenitiesFilterResponse {
  AmenitiesFilterResponse({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory AmenitiesFilterResponse.fromJson(Map<String, dynamic> json) =>
      AmenitiesFilterResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.content,
    required this.pageNumber,
    required this.pageSize,
    required this.totalElements,
  });

  List<Content> content;
  int pageNumber;
  int pageSize;
  int totalElements;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        totalElements: json["totalElements"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "totalElements": totalElements,
      };
}

class Content {
  Content({
    this.id,
    this.name,
    this.description,
    this.status,
    this.categoryId,
    this.icon,
    this.category,
    this.setFilter,
    this.isConfig,
  });

  String? id;
  String? name;
  String? description;
  String? status;
  String? categoryId;
  String? icon;
  Category? category;
  bool? setFilter;
  bool? isConfig;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        categoryId: json["categoryId"],
        icon: json["icon"],
        category: json["category"] != null
            ? Category.fromJson(json["category"])
            : null,
        setFilter: json["setFilter"],
        isConfig: json["isConfig"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "categoryId": categoryId,
        "icon": icon,
        "category": category?.toJson(),
        "setFilter": setFilter,
        "isConfig": isConfig,
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.description,
    this.status,
    this.isDefault,
  });

  String? id;
  String? name;
  String? description;
  String? status;
  bool? isDefault;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "isDefault": isDefault,
      };
}
