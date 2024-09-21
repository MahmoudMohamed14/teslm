class GetUserData {
  String? id;
  String? name;
  String? email;
  String? birthdate;
  String? phoneNumber;
  String? address;
  bool? isDeleted;
  List<Null>? addresses;
  GetUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    birthdate = json['birthdate']??'';
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    isDeleted = json['isDeleted']??false;
    if (json['addresses'] != null) {
      addresses = <Null>[];
    }
  }
}
class Points {
  String? balance;
  int? points;
  String? id;

  Points.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    points = json['points'];
    id = json['id'];
  }
}