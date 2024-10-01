class LoginOTP {
  final String? message;
  final String? token;
  final String? id;

  LoginOTP({this.message, this.token, this.id});
  factory LoginOTP.fromJson(Map<String, dynamic> json) {
    return LoginOTP(
      message: json['message'],
      token: json['token'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    data['id'] = id;
    return data;
  }
}