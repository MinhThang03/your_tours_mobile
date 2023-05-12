import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:your_tours_mobile/constants/api_url.dart';
import 'package:your_tours_mobile/models/responses/aws_response.dart';
import 'package:your_tours_mobile/models/responses/error_response.dart';

Future<UpdateImageResponse> uploadImageApi(String path) async {
  try {
    if (path.isEmpty) {
      return UpdateImageResponse(
          success: true,
          data: ImageResponse(previewUrl: "", createDate: DateTime.now()));
    }

    log(name: 'REQUEST IMAGE:', path);

    var request =
        http.MultipartRequest('POST', Uri.parse(domain + updateImage));
    request.files.add(await http.MultipartFile.fromPath('file', path));
    http.Response response = await request
        .send()
        .then((response) => http.Response.fromStream(response));

    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));

    log(name: 'RESPONSE UPLOAD IMAGE:', responseJson.toString());

    if (response.statusCode == 200) {
      return UpdateImageResponse.fromJson(responseJson);
    }

    ErrorResponse errorResponse = ErrorResponse.fromJson(responseJson);
    throw FormatException(errorResponse.message);
  } on FormatException {
    rethrow;
  } catch (error) {
    throw Exception(error);
  }
}
