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