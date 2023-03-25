class SuccessResponse {
  SuccessResponse({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      SuccessResponse(
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
    required this.success,
  });

  bool success;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}
