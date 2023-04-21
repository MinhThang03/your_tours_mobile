class GetCurrentLocationResponse {
  GetCurrentLocationResponse({required this.success, this.data});

  bool success;
  UserLocation? data;

  factory GetCurrentLocationResponse.fromJson(Map<String, dynamic> json) =>
      GetCurrentLocationResponse(
        success: json["success"] as bool,
        data: json["data"] != null ? UserLocation.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class UserLocation {
  UserLocation({
    this.cityName,
    this.countryName,
  });

  String? cityName;
  String? countryName;

  factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
        cityName: json["cityName"],
        countryName: json["countryName"],
      );

  Map<String, dynamic> toJson() => {
        "cityName": cityName,
        "countryName": countryName,
      };
}
