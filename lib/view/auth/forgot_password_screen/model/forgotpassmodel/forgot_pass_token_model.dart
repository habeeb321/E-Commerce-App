class ForgotPassTokenModel {
  final String accessToken;
  final String refreshToken;

  ForgotPassTokenModel({required this.accessToken, required this.refreshToken});

  factory ForgotPassTokenModel.fromJson(Map<String, dynamic> json) {
    return ForgotPassTokenModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
