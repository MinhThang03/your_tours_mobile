import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/responses/amenities_filter_response.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';

Future<AmenitiesFilterResponse> amenitiesController() async {
  try {
    http.Response response =
        await http.get(Uri.parse(domain + amenitiesFilterUrl));

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      AmenitiesFilterResponse amenitiesResponse =
          AmenitiesFilterResponse.fromJson(responseJson);
      return amenitiesResponse;
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw FormatException(error.toString());
  }
}
