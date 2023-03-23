class RegisterRequest {
  String email;
  String fullName;
  String password;

  RegisterRequest(
      {required this.email, required this.password, required this.fullName});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'fullName': fullName};
  }
}
