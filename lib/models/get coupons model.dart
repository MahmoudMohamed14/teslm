class GetCoupons {
  List<Data>? data;
  int? count;

  GetCoupons.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    count = json['count'];
  }
}

class Data {
  String? id;
  String? code;
  String? type;
  String? status;
  Null? maxAmount;
  int? fixedAmount;
  Null? percentageAmount;
  String? appliedOn;
  Null? minAmount;
  int? usageCount;
  bool? applyToAllProviders;
  List<Null>? providers;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    status = json['status'];
    maxAmount = json['maxAmount'];
    fixedAmount = json['fixedAmount'];
    percentageAmount = json['percentageAmount'];
    appliedOn = json['appliedOn'];
    minAmount = json['minAmount'];
    usageCount = json['usageCount'];
    applyToAllProviders = json['applyToAllProviders'];
  }
}