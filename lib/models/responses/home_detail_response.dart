class HomeDetailResponse {
  HomeDetailResponse({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory HomeDetailResponse.fromJson(Map<String, dynamic> json) =>
      HomeDetailResponse(
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
    required this.id,
    required this.name,
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
    this.roomsOfHome,
    this.amenitiesOfHome,
    this.evaluates,
    this.rooms,
    this.userRate,
    this.dateIsBooked,
    this.ownerName,
    this.amenitiesView,
    this.descriptionHomeDetail,
    this.surcharges,
    this.totalCostBooking,
    this.discounts,
    this.booked,
    this.provinceName,
  });

  String id;
  String name;
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
  String? provinceName;
  int? rank;
  double? costPerNightDefault;
  String? refundPolicy;
  String? status;
  int? numberOfGuests;
  int? view;
  bool? favorite;
  String? thumbnail;
  double? averageRate;
  int? numberOfReviews;
  DateTime? lastModifiedDate;
  List<RoomsImportant>? roomsImportant;
  int? numberOfBed;
  bool? isFavorite;
  List<ImagesOfHome>? imagesOfHome;
  List<RoomsOfHome>? roomsOfHome;
  List<AmenitiesOfHome>? amenitiesOfHome;
  Evaluates? evaluates;
  List<Room>? rooms;
  int? userRate;
  List<String>? dateIsBooked;
  String? ownerName;
  List<AmenitiesView>? amenitiesView;
  String? descriptionHomeDetail;
  List<Surcharge>? surcharges;
  double? totalCostBooking;
  List<Discount>? discounts;
  bool? booked;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        wifi: json["wifi"],
        passWifi: json["passWifi"],
        ruleOthers: json["ruleOthers"],
        timeCheckInStart: json["timeCheckInStart"] == null
            ? null
            : TimeCheck.fromJson(json["timeCheckInStart"]),
        timeCheckInEnd: json["timeCheckInEnd"] == null
            ? null
            : TimeCheck.fromJson(json["timeCheckInEnd"]),
        timeCheckOut: json["timeCheckOut"] == null
            ? null
            : TimeCheck.fromJson(json["timeCheckOut"]),
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
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
        roomsImportant: json["roomsImportant"] == null
            ? null
            : List<RoomsImportant>.from(
                json["roomsImportant"].map((x) => RoomsImportant.fromJson(x))),
        numberOfBed: json["numberOfBed"],
        isFavorite: json["isFavorite"],
        imagesOfHome: json["imagesOfHome"] == null
            ? null
            : List<ImagesOfHome>.from(
                json["imagesOfHome"].map((x) => ImagesOfHome.fromJson(x))),
        roomsOfHome: json["roomsOfHome"] == null
            ? null
            : List<RoomsOfHome>.from(
                json["roomsOfHome"].map((x) => RoomsOfHome.fromJson(x))),
        amenitiesOfHome: json["amenitiesOfHome"] == null
            ? null
            : List<AmenitiesOfHome>.from(json["amenitiesOfHome"]
                .map((x) => AmenitiesOfHome.fromJson(x))),
        evaluates: json["evaluates"] == null
            ? null
            : Evaluates.fromJson(json["evaluates"]),
        rooms: json["rooms"] == null
            ? null
            : List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
        userRate: json["userRate"],
        dateIsBooked: json["dateIsBooked"] == null
            ? null
            : List<String>.from(json["dateIsBooked"].map((x) => x)),
        ownerName: json["ownerName"],
        amenitiesView: json["amenitiesView"] == null
            ? null
            : List<AmenitiesView>.from(
                json["amenitiesView"].map((x) => AmenitiesView.fromJson(x))),
        descriptionHomeDetail: json["descriptionHomeDetail"],
        surcharges: json["surcharges"] == null
            ? null
            : List<Surcharge>.from(
                json["surcharges"].map((x) => Surcharge.fromJson(x))),
        totalCostBooking: json["totalCostBooking"],
        discounts: json["discounts"] == null
            ? null
            : List<Discount>.from(
                json["discounts"].map((x) => Discount.fromJson(x))),
        booked: json["booked"],
      );

  Map<String, dynamic> toJson() =>
      {
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
        "roomsImportant": roomsImportant == null
            ? null
            : List<dynamic>.from(roomsImportant!.map((x) => x.toJson())),
        "numberOfBed": numberOfBed,
        "isFavorite": isFavorite,
        "imagesOfHome": imagesOfHome == null
            ? null
            : List<dynamic>.from(imagesOfHome!.map((x) => x.toJson())),
        "roomsOfHome": roomsOfHome == null
            ? null
            : List<dynamic>.from(roomsOfHome!.map((x) => x.toJson())),
        "amenitiesOfHome": amenitiesOfHome == null
            ? null
            : List<dynamic>.from(amenitiesOfHome!.map((x) => x.toJson())),
        "evaluates": evaluates?.toJson(),
        "rooms": rooms == null
            ? null
            : List<dynamic>.from(rooms!.map((x) => x.toJson())),
        "userRate": userRate,
        "dateIsBooked": dateIsBooked == null
            ? null
            : List<dynamic>.from(dateIsBooked!.map((x) => x)),
        "ownerName": ownerName,
        "amenitiesView": amenitiesView == null
            ? null
            : List<dynamic>.from(amenitiesView!.map((x) => x.toJson())),
        "descriptionHomeDetail": descriptionHomeDetail,
        "surcharges": surcharges == null
            ? null
            : List<dynamic>.from(surcharges!.map((x) => x.toJson())),
        "totalCostBooking": totalCostBooking,
        "discounts": discounts == null
            ? null
            : List<dynamic>.from(discounts!.map((x) => x.toJson())),
        "booked": booked,
      };
}

class AmenitiesOfHome {
  AmenitiesOfHome({
    required this.id,
    required this.isHave,
    required this.amenityId,
    required this.homeId,
  });

  String id;
  bool isHave;
  String amenityId;
  String homeId;

  factory AmenitiesOfHome.fromJson(Map<String, dynamic> json) =>
      AmenitiesOfHome(
        id: json["id"],
        isHave: json["isHave"],
        amenityId: json["amenityId"],
        homeId: json["homeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isHave": isHave,
        "amenityId": amenityId,
        "homeId": homeId,
      };
}

class AmenitiesView {
  AmenitiesView({
    required this.id,
    required this.name,
    this.description,
    this.status,
    this.categoryId,
    this.icon,
    this.category,
    this.setFilter,
    this.isConfig,
  });

  String id;
  String name;
  String? description;
  String? status;
  String? categoryId;
  String? icon;
  AmenitiesViewCategory? category;
  bool? setFilter;
  bool? isConfig;

  factory AmenitiesView.fromJson(Map<String, dynamic> json) => AmenitiesView(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"].toString(),
        categoryId: json["categoryId"],
        icon: json["icon"],
        category: json["category"] == null
            ? null
            : AmenitiesViewCategory.fromJson(json["category"]),
        setFilter: json["setFilter"],
        isConfig: json["isConfig"],
      );

  Map<String, dynamic> toJson() =>
      {
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

class AmenitiesViewCategory {
  AmenitiesViewCategory({
    required this.id,
    required this.name,
    this.description,
    this.status,
    this.isDefault,
  });

  String id;
  String name;
  String? description;
  String? status;
  bool? isDefault;

  factory AmenitiesViewCategory.fromJson(Map<String, dynamic> json) =>
      AmenitiesViewCategory(
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

class Discount {
  Discount({
    required this.category,
    required this.config,
  });

  DiscountCategory category;
  Config config;

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        category: DiscountCategory.fromJson(json["category"]),
        config: Config.fromJson(json["config"]),
      );

  Map<String, dynamic> toJson() => {
        "category": category.toJson(),
        "config": config.toJson(),
      };
}

class DiscountCategory {
  DiscountCategory({
    required this.id,
    required this.name,
    this.description,
    this.type,
    this.numDateDefault,
    this.status,
  });

  String id;
  String name;
  String? description;
  String? type;
  int? numDateDefault;
  String? status;

  factory DiscountCategory.fromJson(Map<String, dynamic> json) =>
      DiscountCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        numDateDefault: json["numDateDefault"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "numDateDefault": numDateDefault,
        "status": status,
      };
}

class Config {
  Config({
    required this.id,
    this.percent,
    this.numberDateStay,
    this.numberMonthAdvance,
    this.homeId,
    this.categoryId,
  });

  String id;
  int? percent;
  int? numberDateStay;
  int? numberMonthAdvance;
  String? homeId;
  String? categoryId;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        id: json["id"],
        percent: json["percent"],
        numberDateStay: json["numberDateStay"],
        numberMonthAdvance: json["numberMonthAdvance"],
        homeId: json["homeId"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "percent": percent,
        "numberDateStay": numberDateStay,
        "numberMonthAdvance": numberMonthAdvance,
        "homeId": homeId,
        "categoryId": categoryId,
      };
}

class Evaluates {
  Evaluates({
    required this.content,
    required this.pageNumber,
    required this.pageSize,
    required this.totalElements,
  });

  List<Content> content;
  int pageNumber;
  int pageSize;
  int totalElements;

  factory Evaluates.fromJson(Map<String, dynamic> json) => Evaluates(
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
    required this.homeId,
    required this.userId,
    required this.point,
    required this.comment,
    required this.userFullName,
  });

  String id;
  String homeId;
  String userId;
  int point;
  String comment;
  String userFullName;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        homeId: json["homeId"],
        userId: json["userId"],
        point: json["point"],
        comment: json["comment"],
        userFullName: json["userFullName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "homeId": homeId,
        "userId": userId,
        "point": point,
        "comment": comment,
        "userFullName": userFullName,
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

class Room {
  Room({
    required this.roomHomeId,
    required this.roomName,
    required this.numberOfBed,
    required this.nameOfBed,
  });

  String roomHomeId;
  String roomName;
  int numberOfBed;
  String nameOfBed;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        roomHomeId: json["roomHomeId"],
        roomName: json["roomName"],
        numberOfBed: json["numberOfBed"],
        nameOfBed: json["nameOfBed"],
      );

  Map<String, dynamic> toJson() => {
        "roomHomeId": roomHomeId,
        "roomName": roomName,
        "numberOfBed": numberOfBed,
        "nameOfBed": nameOfBed,
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

class RoomsOfHome {
  RoomsOfHome({
    required this.categoryId,
    required this.number,
  });

  String categoryId;
  int number;

  factory RoomsOfHome.fromJson(Map<String, dynamic> json) => RoomsOfHome(
        categoryId: json["categoryId"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "number": number,
      };
}

class Surcharge {
  Surcharge({
    required this.surchargeCategoryId,
    required this.surchargeCategoryName,
    required this.cost,
    required this.description,
  });

  String surchargeCategoryId;
  String surchargeCategoryName;
  int cost;
  String description;

  factory Surcharge.fromJson(Map<String, dynamic> json) => Surcharge(
        surchargeCategoryId: json["surchargeCategoryId"],
        surchargeCategoryName: json["surchargeCategoryName"],
        cost: json["cost"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "surchargeCategoryId": surchargeCategoryId,
        "surchargeCategoryName": surchargeCategoryName,
        "cost": cost,
        "description": description,
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
