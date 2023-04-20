import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/requests/booking_request.dart';
import 'package:your_tours_mobile/models/requests/cancel_booking_request.dart';
import 'package:your_tours_mobile/models/responses/book_home_page_response.dart';
import 'package:your_tours_mobile/models/responses/create_booking_response.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';
import 'package:your_tours_mobile/models/responses/register_response.dart';
import 'package:your_tours_mobile/services/token_handler.dart';

Future<SuccessResponse> checkBookingController(
    BookingRequest requestBody) async {
  try {
    String? token = await getToken();
    if (token == null) {
      throw const FormatException("Lỗi chưa đăng nhập");
    }

    http.Response response = await http.post(
      Uri.parse(domain + checkBookingUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody.toJson()),
    );

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return SuccessResponse.fromJson(responseJson);
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw Exception(error);
  }
}

Future<CreateBookingResponse> createBookingController(
    BookingRequest requestBody) async {
  try {
    String? token = await getToken();
    if (token == null) {
      throw const FormatException("Lỗi chưa đăng nhập");
    }

    http.Response response = await http.post(
      Uri.parse(domain + createBookingUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody.toJson()),
    );

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return CreateBookingResponse.fromJson(responseJson);
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw Exception(error);
  }
}

Future<BookHomePageResponse> bookingPageController() async {
  try {
    String? token = await getToken();
    if (token == null) {
      throw const FormatException("Lỗi chưa đăng nhập");
    }

    http.Response response = await http.get(
      Uri.parse(domain + getPageBookingUrl),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return BookHomePageResponse.fromJson(responseJson);
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw FormatException(error.toString());
  }
}

Future<SuccessResponse> cancelBookingPageController(
    CancelBookingRequest requestBody) async {
  try {
    String? token = await getToken();
    if (token == null) {
      throw const FormatException("Lỗi chưa đăng nhập");
    }

    http.Response response = await http.put(
      Uri.parse(domain + cancelBookingUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody.toJson()),
    );
    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return SuccessResponse.fromJson(responseJson);
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw FormatException(error.toString());
  }
}