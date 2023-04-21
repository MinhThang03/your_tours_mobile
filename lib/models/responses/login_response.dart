import 'package:your_tours_mobile/models/responses/location_response.dart';
import 'package:your_tours_mobile/models/responses/user_response.dart';

class LoginResponse {
  LoginResponse({required this.success, this.data});

  bool success;
  Data? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"] as bool,
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.accessToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.refreshToken,
    this.tokenType,
    this.idToken,
    this.notBeforePolicy,
    this.sessionState,
    this.scope,
    this.error,
    this.errorDescription,
    this.errorUri,
    this.userInfo,
    this.deviceLocation,
  });

  String? accessToken;
  int? expiresIn;
  int? refreshExpiresIn;
  String? refreshToken;
  String? tokenType;
  String? idToken;
  int? notBeforePolicy;
  String? sessionState;
  String? scope;
  String? error;
  String? errorDescription;
  String? errorUri;
  UserInfo? userInfo;
  UserLocation? deviceLocation;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        refreshExpiresIn: json["refresh_expires_in"],
        refreshToken: json["refresh_token"],
        tokenType: json["token_type"],
        idToken: json["id_token"],
        notBeforePolicy: json["not-before-policy"],
        sessionState: json["session_state"],
        scope: json["scope"],
        error: json["error"],
        errorDescription: json["error_description"],
        errorUri: json["error_uri"],
        userInfo: UserInfo.fromJson(json["userInfo"]),
        deviceLocation: json["deviceLocation"] == null
            ? null
            : UserLocation.fromJson(json["deviceLocation"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "refresh_expires_in": refreshExpiresIn,
        "refresh_token": refreshToken,
        "token_type": tokenType,
        "id_token": idToken,
        "not-before-policy": notBeforePolicy,
        "session_state": sessionState,
        "scope": scope,
        "error": error,
        "error_description": errorDescription,
        "error_uri": errorUri,
        "userInfo": userInfo?.toJson(),
        "deviceLocation": deviceLocation?.toJson
      };
}


