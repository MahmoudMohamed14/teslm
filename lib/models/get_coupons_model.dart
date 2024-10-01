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
  final String? id;
  final String? code;
  final String? type;
  final String? status;
  final int? maxAmount;
  final int? fixedAmount;
  final Null percentageAmount;
  final String appliedOn;
  final int? minAmount;
  final int? usageCount;
  final bool? applyToAllProviders;
  final List<Providers>? providers;


  CouponData(
      {this.id,
      this.code,
      this.type,
      this.status,
      this.maxAmount,
      this.fixedAmount,
      this.percentageAmount,
      required this.appliedOn,
      this.minAmount,
      this.usageCount,
      this.applyToAllProviders,
      this.providers});

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      id: json['id'],
      code: json['code'],
      type: json['type'],
      status: json['status'],
      maxAmount: json['maxAmount'],
      fixedAmount: json['fixedAmount'],
      percentageAmount: json['percentageAmount'],
      appliedOn: json['appliedOn'],
      minAmount: json['minAmount'],
      usageCount: json['usageCount'],
      applyToAllProviders: json['applyToAllProviders'],
      providers: json['providers'],
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
    data['providers'] = providers;
    return data;
  }
}