import 'package:delivery/models/provider_model.dart';

class GetCouponsModel {
  final List<CouponData>? data;
  final int? count;

  GetCouponsModel({this.data, this.count});

  factory GetCouponsModel.fromJson(Map<String, dynamic> json) {
    return GetCouponsModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => CouponData.fromJson(i)).toList()
          : null,
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class CouponData {
  final String id;
  final String code;
  final String type;
  final String status;
  final double? maxAmount;
  final double? fixedAmount;
  final double? percentageAmount;
  final String appliedOn;
  final double? minAmount;
  final int usageCount;
  final bool applyToAllProviders;
  final String? startDate;
  final String? endDate;
  final int maxUsageCount;
  final double? totalPrice;
  final double? promoterProfit;
  final double? totalDiscount;
  final String createdAt;
  final String updatedAt;

  CouponData({
    required this.id,
    required this.code,
    required this.type,
    required this.status,
    this.maxAmount,
    this.fixedAmount,
    this.percentageAmount,
    required this.appliedOn,
    this.minAmount,
    required this.usageCount,
    required this.applyToAllProviders,
    this.startDate,
    this.endDate,
    required this.maxUsageCount,
    this.totalPrice,
    this.promoterProfit,
    this.totalDiscount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      id: json['id'],
      code: json['code'],
      type: json['type'],
      status: json['status'],
      maxAmount: (json['maxAmount'] as num?)?.toDouble(),
      fixedAmount: (json['fixedAmount'] as num?)?.toDouble(),
      percentageAmount: (json['percentageAmount'] as num?)?.toDouble(),
      appliedOn: json['appliedOn'],
      minAmount: (json['minAmount'] as num?)?.toDouble(),
      usageCount: json['usageCount'] ?? 0,
      applyToAllProviders: json['applyToAllProviders'] ?? false,
      startDate: json['startDate'],
      endDate: json['endDate'],
      maxUsageCount: json['maxUsageCount'] ?? 0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      promoterProfit: (json['promoterProfit'] as num?)?.toDouble(),
      totalDiscount: (json['totalDiscount'] as num?)?.toDouble(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['type'] = type;
    data['status'] = status;
    data['maxAmount'] = maxAmount;
    data['fixedAmount'] = fixedAmount;
    data['percentageAmount'] = percentageAmount;
    data['appliedOn'] = appliedOn;
    data['minAmount'] = minAmount;
    data['usageCount'] = usageCount;
    data['applyToAllProviders'] = applyToAllProviders;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
