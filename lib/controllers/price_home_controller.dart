import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/requests/favourite_request.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';
import 'package:your_tours_mobile/models/responses/price_of_home_response.dart';
import 'package:your_tours_mobile/models/responses/register_response.dart';

import '../services/token_handler.dart';

Future<PriceOfHomeResponse> getPriceOfHome(
    String homeId, String dateFrom, String dateTo) async {
  try {
    homeId = "homeId=$homeId";
    dateFrom = "dateFrom=$dateFrom";
    dateTo = "dateTo=$dateTo";

    String url = getPriceOfHomeUrl
        .replaceAll("{homeId}", homeId)
        .replaceAll("{dateFrom}", dateFrom)
        .replaceAll("{dateTo}", dateTo);

    http.Response response = await http.get(
      Uri.parse(domain + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return PriceOfHomeResponse.fromJson(responseJson);
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw FormatException(error.toString());
  }
}

Future<SuccessResponse> favouriteHandlerController(
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
