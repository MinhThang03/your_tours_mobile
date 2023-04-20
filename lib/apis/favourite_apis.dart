import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/requests/favourite_request.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';
import 'package:your_tours_mobile/models/responses/register_response.dart';

import '../models/responses/home_info_response.dart';
import '../services/token_handler.dart';

Future<HomeInfoResponse> favouritePageApi() async {
  try {
    String? token = await getToken();
    if (token == null) {
      throw const FormatException("Lỗi chưa đăng nhập");
    }

    http.Response response = await http.get(
      Uri.parse(domain + favouritePageUrl),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      HomeInfoResponse homeInfoResponse =
          HomeInfoResponse.fromJson(responseJson);
      return homeInfoResponse;
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw FormatException(error.toString());
  }
}

Future<SuccessResponse> favouriteHandlerApi(
    FavouriteRequest requestBody) async {
  try {
    String? token = await getToken();
    if (token == null) {
      throw const FormatException("Lỗi chưa đăng nhập");
    }

    http.Response response = await http.post(
      Uri.parse(domain + favouriteUrl),
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
