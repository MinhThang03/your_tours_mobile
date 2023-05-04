import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';

Future<HomeDetailResponse> homeDetailApi(String homeId) async {
  try {
    http.Response response = await http
        .get(Uri.parse(domain + homeDetailUrl.replaceAll("{homeId}", homeId)));

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    log(name: 'RESPONSE HOME DETAIL:', responseJson.toString());

    if (response.statusCode == 200) {
      HomeDetailResponse homeDetailResponse =
          HomeDetailResponse.fromJson(responseJson);
      return homeDetailResponse;
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw FormatException(error.toString());
  }
}
