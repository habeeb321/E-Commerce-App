class LoginTokenModel {
  final String accessToken;
  final String refreshToken;

  LoginTokenModel({required this.accessToken, required this.refreshToken});

  factory LoginTokenModel.fromJson(Map<String, dynamic> json) {
    return LoginTokenModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
