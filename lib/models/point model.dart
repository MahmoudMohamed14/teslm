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