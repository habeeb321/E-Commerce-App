class ForgotPasswordModel {
  final String email;
  final String password;

  ForgotPasswordModel({required this.email, required this.password});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "email":email,
      "password":password,
    };
  }
}
