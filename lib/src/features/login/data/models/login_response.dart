class LoginResponse {
  final int? statusCode;
  final String? accessToken;
  final String? message;

  LoginResponse({this.accessToken, this.message, this.statusCode});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: json['status_code'],
      accessToken: json['access_token'],
      message: json['message'],
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'access_token': accessToken,
      'message': message,
    };
  }

  //copy with
  LoginResponse copyWith({
    int? statusCode,
    String? accessToken,
    String? message,
  }) {
    return LoginResponse(
      statusCode: statusCode ?? this.statusCode,
      accessToken: accessToken ?? this.accessToken,
      message: message ?? this.message,
    );
  }
}
