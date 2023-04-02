import 'package:your_tours_mobile/models/responses/book_home_page_response.dart';

class CreateBookingResponse {
  CreateBookingResponse({
    required this.success,
    required this.data,
  });

  bool success;
  BookingInfo data;

  factory CreateBookingResponse.fromJson(Map<String, dynamic> json) =>
      CreateBookingResponse(
        success: json["success"],
        data: BookingInfo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}
