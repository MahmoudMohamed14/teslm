class Coupon {
  final int? discount;
  final String? appliedOn;

  Coupon({
    this.discount,
    this.appliedOn,
  });
  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      discount: json['discount'],
      appliedOn: json['appliedOn'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discount'] = discount;
    data['appliedOn'] = appliedOn;
    return data;
  }
}