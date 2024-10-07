class PostCoupon {
  final String? couponCode;

  PostCoupon({this.couponCode});

  factory PostCoupon.fromJson(Map<String, dynamic> json) {
    return PostCoupon(
      couponCode: json['couponCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['couponCode'] = couponCode;
    return data;
  }
}