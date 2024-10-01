class GetUserData {
  final String? id;
  final String? name;
  final String? email;
  final String? birthdate;
  final String? phoneNumber;
  final String? address;
  final bool? isDeleted;
  final List<Null>? addresses;


  GetUserData({this.id, this.name, this.email, this.birthdate, this.phoneNumber, this.address, this.isDeleted, this.addresses});
  factory GetUserData.fromJson(Map<String, dynamic> json) {
    return GetUserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      birthdate: json['birthdate'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      isDeleted: json['isDeleted'],
      addresses: json['addresses'],
    );
  }
}
class Points {
  final String? balance;
  final int? points;
  final String? id;

  Points({this.balance, this.points, this.id});

  factory Points.fromJson(Map<String, dynamic> json) {
    return Points(
      balance: json['balance'],
      points: json['points'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    data['points'] = points;
    data['id'] = id;
    return data;
  }
}