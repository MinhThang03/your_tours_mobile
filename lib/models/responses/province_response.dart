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
    required this.divisionType,
    required this.thumbnail,
    required this.enName,
  });

  int? id;
  String codeName;
  String name;
  String divisionType;
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
