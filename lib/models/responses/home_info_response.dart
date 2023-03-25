class HomeInfoResponse {
  HomeInfoResponse({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory HomeInfoResponse.fromJson(Map<String, dynamic> json) =>
      HomeInfoResponse(
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

  List<HomeInfo> content;
  int pageNumber;
  int pageSize;
  int totalElements;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: List<HomeInfo>.from(
            json["content"].map((x) => HomeInfo.fromJson(x))),
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

class HomeInfo {
  HomeInfo({
    required this.id,
    this.name,
    this.description,
    this.wifi,
    this.passWifi,
    this.ruleOthers,
    this.timeCheckInStart,
    this.timeCheckInEnd,
    this.timeCheckOut,
    this.guide,
    this.addressDetail,
    this.provinceCode,
    this.rank,
    this.costPerNightDefault,
    this.refundPolicy,
    this.status,
    this.numberOfGuests,
    this.view,
    this.favorite,
    this.thumbnail,
    this.averageRate,
    this.numberOfReviews,
    this.lastModifiedDate,
    this.roomsImportant,
    this.numberOfBed,
    this.isFavorite,
    this.imagesOfHome,
    this.provinceName,
  });

  String id;
  String? name;
  String? description;
  String? wifi;
  String? passWifi;
  String? ruleOthers;
  TimeCheck? timeCheckInStart;
  TimeCheck? timeCheckInEnd;
  TimeCheck? timeCheckOut;
  String? guide;
  String? addressDetail;
  String? provinceCode;
  int? rank;
  double? costPerNightDefault;
  String? refundPolicy;
  String? status;
  int? numberOfGuests;
  int? view;
  int? favorite;
  String? thumbnail;
  int? averageRate;
  int? numberOfReviews;
  DateTime? lastModifiedDate;
  List<RoomsImportant>? roomsImportant;
  int? numberOfBed;
  bool? isFavorite;
  String? provinceName;
  List<ImagesOfHome>? imagesOfHome;

  factory HomeInfo.fromJson(Map<String, dynamic> json) => HomeInfo(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        wifi: json["wifi"],
        passWifi: json["passWifi"],
        ruleOthers: json["ruleOthers"],
        timeCheckInStart: json["timeCheckInStart"] != null
            ? TimeCheck.fromJson(json["timeCheckInStart"])
            : null,
        timeCheckInEnd: json["timeCheckInEnd"] != null
            ? TimeCheck.fromJson(json["timeCheckInEnd"])
            : null,
        timeCheckOut: json["timeCheckOut"] != null
            ? TimeCheck.fromJson(json["timeCheckOut"])
            : null,
        guide: json["guide"],
        addressDetail: json["addressDetail"],
        provinceCode: json["provinceCode"],
        provinceName: json["provinceName"],
        rank: json["rank"],
        costPerNightDefault: json["costPerNightDefault"],
        refundPolicy: json["refundPolicy"],
        status: json["status"],
        numberOfGuests: json["numberOfGuests"],
        view: json["view"],
        favorite: json["favorite"],
        thumbnail: json["thumbnail"],
        averageRate: json["averageRate"],
        numberOfReviews: json["numberOfReviews"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        roomsImportant: json["roomsImportant"] != null
            ? List<RoomsImportant>.from(
                json["roomsImportant"].map((x) => RoomsImportant.fromJson(x)))
            : null,
        numberOfBed: json["numberOfBed"],
        isFavorite: json["isFavorite"],
        imagesOfHome: json["imagesOfHome"] != null
            ? List<ImagesOfHome>.from(
                json["imagesOfHome"].map((x) => ImagesOfHome.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "wifi": wifi,
        "passWifi": passWifi,
        "ruleOthers": ruleOthers,
        "timeCheckInStart": timeCheckInStart?.toJson(),
        "timeCheckInEnd": timeCheckInEnd?.toJson(),
        "timeCheckOut": timeCheckOut?.toJson(),
        "guide": guide,
        "addressDetail": addressDetail,
        "provinceCode": provinceCode,
        "provinceName": provinceName,
        "rank": rank,
        "costPerNightDefault": costPerNightDefault,
        "refundPolicy": refundPolicy,
        "status": status,
        "numberOfGuests": numberOfGuests,
        "view": view,
        "favorite": favorite,
        "thumbnail": thumbnail,
        "averageRate": averageRate,
        "numberOfReviews": numberOfReviews,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "roomsImportant": roomsImportant != null
            ? List<dynamic>.from(roomsImportant!.map((x) => x.toJson()))
            : null,
        "numberOfBed": numberOfBed,
        "isFavorite": isFavorite,
        "imagesOfHome": imagesOfHome != null
            ? List<dynamic>.from(imagesOfHome!.map((x) => x.toJson()))
            : null,
      };
}

class ImagesOfHome {
  ImagesOfHome({
    required this.id,
    required this.path,
  });

  String id;
  String path;

  factory ImagesOfHome.fromJson(Map<String, dynamic> json) => ImagesOfHome(
        id: json["id"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
      };
}

class RoomsImportant {
  RoomsImportant({
    required this.roomCategoryName,
    required this.roomCategoryId,
    required this.number,
  });

  String roomCategoryName;
  String roomCategoryId;
  String number;

  factory RoomsImportant.fromJson(Map<String, dynamic> json) => RoomsImportant(
        roomCategoryName: json["roomCategoryName"],
        roomCategoryId: json["roomCategoryId"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "roomCategoryName": roomCategoryName,
        "roomCategoryId": roomCategoryId,
        "number": number,
      };
}

class TimeCheck {
  TimeCheck({
    required this.hour,
    required this.minute,
    required this.second,
    required this.nano,
  });

  int hour;
  int minute;
  int second;
  int nano;

  factory TimeCheck.fromJson(Map<String, dynamic> json) => TimeCheck(
        hour: json["hour"],
        minute: json["minute"],
        second: json["second"],
        nano: json["nano"],
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "minute": minute,
        "second": second,
        "nano": nano,
      };
}
