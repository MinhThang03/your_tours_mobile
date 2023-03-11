import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';
import 'package:your_tours_mobile/models/responses/home_page_filter_response.dart';

Future<HomePageFilterResponse> homePageController(
    String? amenityId, String? province) async {
  try {
    String amenityParam = '';
    String provinceParam = '';

    if (amenityId != null) {
      amenityParam = "&amenityId=$amenityId";
    }

    if (province != null) {
      provinceParam = "&province=$province";
    }

    http.Response response = await http.get(
        Uri.parse(domain + homePageFilterUrl + amenityParam + provinceParam));

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      HomePageFilterResponse homePageFilterResponse =
          HomePageFilterResponse.fromJson(responseJson);
      return homePageFilterResponse;
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw FormatException(error.toString());
  }
}
