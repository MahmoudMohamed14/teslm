class LoginOTP {
  String? message;
  String? token;
  String? id;
  LoginOTP.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    id = json['id'];
  }
}