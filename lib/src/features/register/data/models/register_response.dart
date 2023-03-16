class RegisterResponse {
  final int? statusCode;
  final String? accessToken;
  final String? message;
  final List<ErrorItem>? errors;

  RegisterResponse(
      {this.accessToken, this.message, this.statusCode, this.errors});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      statusCode: json['status_code'],
      accessToken: json['access_token'],
      message: json['message'],
      errors: json['error'] != null
          ? List<ErrorItem>.from(json['error'].map((x) => x))
          : null,
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'access_token': accessToken,
      'message': message,
      'error': errors,
    };
  }

  //copy with
  RegisterResponse copyWith({
    int? statusCode,
    String? accessToken,
    String? message,
    List<ErrorItem>? errors,
  }) {
    return RegisterResponse(
      statusCode: statusCode ?? this.statusCode,
      accessToken: accessToken ?? this.accessToken,
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }
}

class ErrorItem {
  final String key;
  final List<String> messages;

  ErrorItem({required this.key, required this.messages});

  factory ErrorItem.fromJson(Map<String, dynamic> json) {
    String key = json.keys.first;
    List<String> messages = List<String>.from(json.values.first);

    return ErrorItem(key: key, messages: messages);
  }

  @override
  String toString() {
    return messages.join("\n");
  }
}
