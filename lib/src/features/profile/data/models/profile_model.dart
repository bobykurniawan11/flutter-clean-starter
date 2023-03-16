class ProfileModel {
  final String fullname;
  final String email;

  ProfileModel({
    required this.fullname,
    required this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullname: json['fullname'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'email': email,
    };
  }
}
