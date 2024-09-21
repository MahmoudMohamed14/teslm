class Coupon {
  int? discount;
  String? appliedOn;

  Coupon.fromJson(Map<String, dynamic> json) {
    discount = json['discount'];
    appliedOn = json['appliedOn'];
  }
}