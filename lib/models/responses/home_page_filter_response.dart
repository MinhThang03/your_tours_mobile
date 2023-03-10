class HomePageFilterResponse {
  HomePageFilterResponse({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory HomePageFilterResponse.fromJson(Map<String, dynamic> json) =>
      HomePageFilterResponse(
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
    required this.id,
    required this.name,
    required this.description,
    required this.wifi,
    required this.passWifi,
    required this.ruleOthers,
    required this.timeCheckInStart,
    required this.timeCheckInEnd,
    required this.timeCheckOut,
    required this.guide,
    required this.addressDetail,
    required this.provinceCode,
    required this.rank,
    required this.costPerNightDefault,
    required this.refundPolicy,
    required this.status,
    required this.numberOfGuests,
    required this.view,
    required this.favorite,
    required this.thumbnail,
    required this.averageRate,
    required this.numberOfReviews,
    required this.lastModifiedDate,
    required this.roomsImportant,
    required this.numberOfBed,
    required this.isFavorite,
    required this.imagesOfHome,
  });

  String id;
  String name;
  String description;
  String wifi;
  String passWifi;
  String ruleOthers;
  TimeCheck timeCheckInStart;
  TimeCheck timeCheckInEnd;
  TimeCheck timeCheckOut;
  String guide;
  String addressDetail;
  int provinceCode;
  int rank;
  int costPerNightDefault;
  String refundPolicy;
  String status;
  int numberOfGuests;
  int view;
  int favorite;
  String thumbnail;
  int averageRate;
  int numberOfReviews;
  DateTime lastModifiedDate;
  List<RoomsImportant> roomsImportant;
  int numberOfBed;
  bool isFavorite;
  List<ImagesOfHome> imagesOfHome;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        wifi: json["wifi"],
        passWifi: json["passWifi"],
        ruleOthers: json["ruleOthers"],
        timeCheckInStart: TimeCheck.fromJson(json["timeCheckInStart"]),
        timeCheckInEnd: TimeCheck.fromJson(json["timeCheckInEnd"]),
        timeCheckOut: TimeCheck.fromJson(json["timeCheckOut"]),
        guide: json["guide"],
        addressDetail: json["addressDetail"],
        provinceCode: json["provinceCode"],
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
        roomsImportant: List<RoomsImportant>.from(
            json["roomsImportant"].map((x) => RoomsImportant.fromJson(x))),
        numberOfBed: json["numberOfBed"],
        isFavorite: json["isFavorite"],
        imagesOfHome: List<ImagesOfHome>.from(
            json["imagesOfHome"].map((x) => ImagesOfHome.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "wifi": wifi,
        "passWifi": passWifi,
        "ruleOthers": ruleOthers,
        "timeCheckInStart": timeCheckInStart.toJson(),
        "timeCheckInEnd": timeCheckInEnd.toJson(),
        "timeCheckOut": timeCheckOut.toJson(),
        "guide": guide,
        "addressDetail": addressDetail,
        "provinceCode": provinceCode,
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
        "lastModifiedDate": lastModifiedDate.toIso8601String(),
        "roomsImportant":
            List<dynamic>.from(roomsImportant.map((x) => x.toJson())),
        "numberOfBed": numberOfBed,
        "isFavorite": isFavorite,
        "imagesOfHome": List<dynamic>.from(imagesOfHome.map((x) => x.toJson())),
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
