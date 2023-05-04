import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/responses/comment_response.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';

Future<GetPageCommentResponse> getPageCommentApi(String homeId,
    {int size = 5}) async {
  try {
    String param = getPageComment
        .replaceAll("{homeId}", homeId)
        .replaceAll("{size}", size.toString());

    log(name: 'REQUEST JSON:', param);

    http.Response response = await http.get(
      Uri.parse(domain + param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    log(name: 'RESPONSE JSON:', responseJson.toString());

    if (response.statusCode == 200) {
      return GetPageCommentResponse.fromJson(responseJson);
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw Exception(error);
  }
}
