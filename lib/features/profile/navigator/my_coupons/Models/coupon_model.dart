// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  final List<Datum>? data;
  final int? count;

  CouponModel({
    this.data,
    this.count,
  });

  CouponModel copyWith({
    List<Datum>? data,
    int? count,
  }) =>
      CouponModel(
        data: data ?? this.data,
        count: count ?? this.count,
      );

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "count": count,
      };
}

class Datum {
  final String? id;
  final String? code;
  final String? type;
  final String? status;
  final dynamic maxAmount;
  final double? fixedAmount;
  final dynamic percentageAmount;
  final String? appliedOn;
  final dynamic minAmount;
  final int? usageCount;
  final bool? applyToAllProviders;
  final dynamic startDate;
  final dynamic endDate;
  final int? maxUsageCount;
  final int? totalPrice;
  final dynamic promoterProfit;
  final int? totalDiscount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic>? providers;

  Datum({
    this.id,
    this.code,
    this.type,
    this.status,
    this.maxAmount,
    this.fixedAmount,
    this.percentageAmount,
    this.appliedOn,
    this.minAmount,
    this.usageCount,
    this.applyToAllProviders,
    this.startDate,
    this.endDate,
    this.maxUsageCount,
    this.totalPrice,
    this.promoterProfit,
    this.totalDiscount,
    this.createdAt,
    this.updatedAt,
    this.providers,
  });

  Datum copyWith({
    String? id,
    String? code,
    String? type,
    String? status,
    dynamic maxAmount,
    double? fixedAmount,
    dynamic percentageAmount,
    String? appliedOn,
    dynamic minAmount,
    int? usageCount,
    bool? applyToAllProviders,
    dynamic startDate,
    dynamic endDate,
    int? maxUsageCount,
    int? totalPrice,
    dynamic promoterProfit,
    int? totalDiscount,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic>? providers,
  }) =>
      Datum(
        id: id ?? this.id,
        code: code ?? this.code,
        type: type ?? this.type,
        status: status ?? this.status,
        maxAmount: maxAmount ?? this.maxAmount,
        fixedAmount: fixedAmount ?? this.fixedAmount,
        percentageAmount: percentageAmount ?? this.percentageAmount,
        appliedOn: appliedOn ?? this.appliedOn,
        minAmount: minAmount ?? this.minAmount,
        usageCount: usageCount ?? this.usageCount,
        applyToAllProviders: applyToAllProviders ?? this.applyToAllProviders,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        maxUsageCount: maxUsageCount ?? this.maxUsageCount,
        totalPrice: totalPrice ?? this.totalPrice,
        promoterProfit: promoterProfit ?? this.promoterProfit,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        providers: providers ?? this.providers,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        type: json["type"],
        status: json["status"],
        maxAmount: json["maxAmount"],
        fixedAmount: json["fixedAmount"]?.toDouble(),
        percentageAmount: json["percentageAmount"],
        appliedOn: json["appliedOn"],
        minAmount: json["minAmount"],
        usageCount: json["usageCount"],
        applyToAllProviders: json["applyToAllProviders"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        maxUsageCount: json["maxUsageCount"],
        totalPrice: json["totalPrice"],
        promoterProfit: json["promoterProfit"],
        totalDiscount: json["totalDiscount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        providers: json["providers"] == null
            ? []
            : List<dynamic>.from(json["providers"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "type": type,
        "status": status,
        "maxAmount": maxAmount,
        "fixedAmount": fixedAmount,
        "percentageAmount": percentageAmount,
        "appliedOn": appliedOn,
        "minAmount": minAmount,
        "usageCount": usageCount,
        "applyToAllProviders": applyToAllProviders,
        "startDate": startDate,
        "endDate": endDate,
        "maxUsageCount": maxUsageCount,
        "totalPrice": totalPrice,
        "promoterProfit": promoterProfit,
        "totalDiscount": totalDiscount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "providers": providers == null
            ? []
            : List<dynamic>.from(providers!.map((x) => x)),
      };
}
