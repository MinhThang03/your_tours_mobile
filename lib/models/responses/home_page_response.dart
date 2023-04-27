class HomePageResponse {
  HomePageResponse({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory HomePageResponse.fromJson(Map<String, dynamic> json) =>
      HomePageResponse(
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

  List<MobileHomeInfo> content;
  int pageNumber;
  int pageSize;
  int totalElements;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: List<MobileHomeInfo>.from(
            json["content"].map((x) => MobileHomeInfo.fromJson(x))),
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

class MobileHomeInfo {
  MobileHomeInfo({
    required this.id,
    required this.name,
    required this.costPerNightDefault,
    required this.view,
    required this.numberOfBooking,
    required this.favorite,
    required this.thumbnail,
    required this.averageRate,
    required this.numberOfReviews,
    required this.isFavorite,
    required this.provinceName,
  });

  String id;
  String name;
  int view;
  int favorite;
  String thumbnail;
  double averageRate;
  double costPerNightDefault;
  int numberOfBooking;
  int numberOfReviews;
  bool isFavorite;
  String provinceName;

  factory MobileHomeInfo.fromJson(Map<String, dynamic> json) => MobileHomeInfo(
        id: json["id"],
        name: json["name"],
        provinceName: json["provinceName"],
        costPerNightDefault: json["costPerNightDefault"],
        view: json["view"],
        favorite: json["favorite"],
        thumbnail: json["thumbnail"],
        averageRate: json["averageRate"],
        numberOfReviews: json["numberOfReviews"],
        isFavorite: json["isFavorite"],
        numberOfBooking: json["numberOfBooking"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "provinceName": provinceName,
        "costPerNightDefault": costPerNightDefault,
        "view": view,
        "favorite": favorite,
        "thumbnail": thumbnail,
        "averageRate": averageRate,
        "numberOfReviews": numberOfReviews,
        "isFavorite": isFavorite,
        "numberOfBooking": numberOfBooking,
      };
}
