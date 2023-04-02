class PriceOfHomeResponse {
  PriceOfHomeResponse({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory PriceOfHomeResponse.fromJson(Map<String, dynamic> json) =>
      PriceOfHomeResponse(
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
    required this.totalCost,
    this.percent,
    this.discountName,
    required this.detail,
    required this.totalCostWithSurcharge,
    required this.totalCostWithNoDiscount,
    required this.surchargeCost,
  });

  double totalCost;
  double? percent;
  String? discountName;
  List<Detail> detail;
  double totalCostWithSurcharge;
  double totalCostWithNoDiscount;
  double surchargeCost;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCost: json["totalCost"],
        percent: json["percent"],
        discountName: json["discountName"],
        detail:
            List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
        totalCostWithSurcharge: json["totalCostWithSurcharge"],
        totalCostWithNoDiscount: json["totalCostWithNoDiscount"],
        surchargeCost: json["surchargeCost"],
      );

  Map<String, dynamic> toJson() => {
        "totalCost": totalCost,
        "percent": percent,
        "discountName": discountName,
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
        "totalCostWithSurcharge": totalCostWithSurcharge,
        "totalCostWithNoDiscount": totalCostWithNoDiscount,
        "surchargeCost": surchargeCost,
      };
}

class Detail {
  Detail({
    required this.cost,
    required this.day,
    required this.especially,
  });

  double cost;
  DateTime day;
  bool especially;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        cost: json["cost"],
        day: DateTime.parse(json["day"]),
        especially: json["especially"],
      );

  Map<String, dynamic> toJson() => {
        "cost": cost,
        "day":
            "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "especially": especially,
      };
}
