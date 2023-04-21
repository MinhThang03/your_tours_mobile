class BookHomePageResponse {
  BookHomePageResponse({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory BookHomePageResponse.fromJson(Map<String, dynamic> json) =>
      BookHomePageResponse(
        success: json["success"] ?? false,
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

  List<BookingInfo> content;
  int pageNumber;
  int pageSize;
  int totalElements;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: List<BookingInfo>.from(
            json["content"].map((x) => BookingInfo.fromJson(x))),
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

class BookingInfo {
  BookingInfo({
    required this.id,
    required this.dateStart,
    required this.dateEnd,
    this.phoneNumber,
    this.email,
    this.cost,
    this.paymentMethod,
    this.visaAccount,
    required this.homeId,
    required this.userId,
    required this.status,
    required this.homeName,
    this.customerName,
    required this.thumbnail,
    this.owner,
    required this.totalCost,
    this.numberOfGuests,
    required this.homeAddressDetail,
    this.homeProvinceCode,
    this.percent,
    this.surcharges,
    this.guests,
    this.costOfHost,
    this.costOfAdmin,
    this.refundPolicy,
    this.moneyPayed,
  });

  String id;
  DateTime dateStart;
  DateTime dateEnd;
  String? phoneNumber;
  String? email;
  double? cost;
  String? paymentMethod;
  String? visaAccount;
  String? homeId;
  String? userId;
  String status;
  String homeName;
  String? customerName;
  String thumbnail;
  String? owner;
  double totalCost;
  int? numberOfGuests;
  String homeAddressDetail;
  String? homeProvinceCode;
  double? percent;
  List<Surcharge>? surcharges;
  List<Guest>? guests;
  double? costOfHost;
  double? costOfAdmin;
  String? refundPolicy;
  double? moneyPayed;

  factory BookingInfo.fromJson(Map<String, dynamic> json) => BookingInfo(
        id: json["id"],
        dateStart: DateTime.parse(json["dateStart"]),
        dateEnd: DateTime.parse(json["dateEnd"]),
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        cost: json["cost"],
        paymentMethod: json["paymentMethod"],
        visaAccount: json["visaAccount"],
        homeId: json["homeId"],
        userId: json["userId"],
        status: json["status"],
        homeName: json["homeName"],
        customerName: json["customerName"],
        thumbnail: json["thumbnail"],
        owner: json["owner"],
        totalCost: json["totalCost"],
        numberOfGuests: json["numberOfGuests"],
        homeAddressDetail: json["homeAddressDetail"],
        homeProvinceCode: json["homeProvinceCode"],
        percent: json["percent"],
        surcharges: json["surcharges"] == null
            ? null
            : List<Surcharge>.from(
                json["surcharges"].map((x) => Surcharge.fromJson(x))),
        guests: json["guests"] == null
            ? null
            : List<Guest>.from(json["guests"].map((x) => Guest.fromJson(x))),
        costOfHost: json["costOfHost"],
        costOfAdmin: json["costOfAdmin"],
        refundPolicy: json["refundPolicy"],
        moneyPayed: json["moneyPayed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateStart":
            "${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}",
        "dateEnd":
            "${dateEnd.year.toString().padLeft(4, '0')}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}",
        "phoneNumber": phoneNumber,
        "email": email,
        "cost": cost,
        "paymentMethod": paymentMethod,
        "visaAccount": visaAccount,
        "homeId": homeId,
        "userId": userId,
        "status": status,
        "homeName": homeName,
        "customerName": customerName,
        "thumbnail": thumbnail,
        "owner": owner,
        "totalCost": totalCost,
        "numberOfGuests": numberOfGuests,
        "homeAddressDetail": homeAddressDetail,
        "homeProvinceCode": homeProvinceCode,
        "percent": percent,
        "surcharges": surcharges == null
            ? null
            : List<dynamic>.from(surcharges!.map((x) => x.toJson())),
        "guests": guests == null
            ? null
            : List<dynamic>.from(guests!.map((x) => x.toJson())),
        "costOfHost": costOfHost,
        "costOfAdmin": costOfAdmin,
        "refundPolicy": refundPolicy,
        "moneyPayed": moneyPayed,
      };
}

class Guest {
  Guest({
    required this.id,
    required this.guestCategory,
    required this.number,
    required this.booking,
  });

  String id;
  String guestCategory;
  int number;
  String booking;

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        id: json["id"],
        guestCategory: json["guestCategory"],
        number: json["number"],
        booking: json["booking"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guestCategory": guestCategory,
        "number": number,
        "booking": booking,
      };
}

class Surcharge {
  Surcharge({
    required this.id,
    required this.surchargeId,
    required this.booking,
    required this.costOfSurcharge,
  });

  String id;
  String surchargeId;
  String booking;
  double costOfSurcharge;

  factory Surcharge.fromJson(Map<String, dynamic> json) => Surcharge(
        id: json["id"],
        surchargeId: json["surchargeId"],
        booking: json["booking"],
        costOfSurcharge: json["costOfSurcharge"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "surchargeId": surchargeId,
        "booking": booking,
        "costOfSurcharge": costOfSurcharge,
      };
}
