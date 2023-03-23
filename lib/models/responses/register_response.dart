class RegisterResponse {
  RegisterResponse({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
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
