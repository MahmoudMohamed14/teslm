class Advertising {
  List<Data>? data;
  int? count;

  Advertising.fromJson(Map<String, dynamic> json) {
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
  DataTranslate? name;
  String? image;
  ProvidersOffer? provider;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new DataTranslate.fromJson(json['name']) : null;
    image = json['image'];
    provider = json['provider'] != null
        ? new ProvidersOffer.fromJson(json['provider'])
        : null;
  }
}

class DataTranslate {
  String? ar;
  String? en;

  DataTranslate.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }
}

class ProvidersOffer {
  String? id;
  DataTranslate? providerName;
  String? providerImage;
  String? providerCover;
  DataTranslate? description;
  String? createdAt;
  int? totalReviews;
  int? reviewCount;

  ProvidersOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'] != null
        ? new DataTranslate.fromJson(json['provider_name'])
        : null;
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'] != null
        ? new DataTranslate.fromJson(json['description'])
        : null;
    createdAt = json['createdAt'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
  }
}
