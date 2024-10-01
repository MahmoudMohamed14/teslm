class PointsAndBalanceModel {
  final String? balance;
  final int? points;
  final String? id;

  PointsAndBalanceModel({this.balance, this.points, this.id});

  factory PointsAndBalanceModel.fromJson(Map<String, dynamic> json) {
    return PointsAndBalanceModel(
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