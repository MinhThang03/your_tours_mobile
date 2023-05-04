class GetListProvinceResponse {
  GetListProvinceResponse({
    required this.success,
    required this.data,
  });

  bool success;
  List<Province> data;

  factory GetListProvinceResponse.fromJson(Map<String, dynamic> json) =>
      GetListProvinceResponse(
        success: json["success"],
        data:
            List<Province>.from(json["data"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    this.id,
    required this.codeName,
    required this.name,
    this.divisionType,
    required this.thumbnail,
    required this.enName,
  });

  int? id;
  String codeName;
  String name;
  String? divisionType;
  String thumbnail;
  String enName;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        codeName: json["codeName"],
        name: json["name"],
        divisionType: json["divisionType"],
        thumbnail: json["thumbnail"],
        enName: json['enName'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codeName": codeName,
        "name": name,
        "divisionType": divisionType,
        "thumbnail": thumbnail,
        "enName": enName,
      };
}

class GetPageProvinceResponse {
  GetPageProvinceResponse({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory GetPageProvinceResponse.fromJson(Map<String, dynamic> json) =>
      GetPageProvinceResponse(
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

  List<Province> content;
  int pageNumber;
  int pageSize;
  int totalElements;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: List<Province>.from(
            json["content"].map((x) => Province.fromJson(x))),
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
