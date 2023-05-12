class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class ResetPasswordRequest {
  String otp;
  String newPassword;
  String confirmPassword;

  ResetPasswordRequest(
      {required this.otp,
      required this.newPassword,
      required this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
  }
}
