class ActiveAccountRequest {
  String otp;

  ActiveAccountRequest({required this.otp});

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
    };
  }
}
