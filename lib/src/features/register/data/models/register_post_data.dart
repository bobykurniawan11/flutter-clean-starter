class RegisterPostData {
  final String email;
  final String password;
  final String password_confirmation;
  final String fullname;
  final String phone;

  RegisterPostData({
    required this.email,
    required this.password,
    required this.password_confirmation,
    required this.fullname,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'fullname': fullname,
      'phone': phone,
    };
  }
}
