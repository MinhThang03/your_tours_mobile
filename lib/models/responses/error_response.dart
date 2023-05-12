class ErrorResponse {
  ErrorResponse(
      {required this.success, required this.message, required this.code});

  bool success;
  String message;
  String code;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? json["error"] ?? '',
        code: json["code"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "code": code,
      };
}
