class LoginUser {
  String? message;
  LoginUser.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}