class LoginRequest {
  String email;
  String password;
  bool getLocation;

  LoginRequest(
      {required this.email, required this.password, this.getLocation = true});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'getLocation': getLocation,
    };
  }
}
