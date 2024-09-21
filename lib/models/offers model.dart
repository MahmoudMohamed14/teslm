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
  Name? name;
  String? image;
  ProviderOffer? provider;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    provider = json['provider'] != null
        ? new ProviderOffer.fromJson(json['provider'])
        : null;
  }
}

class Name {
  String? ar;
  String? en;

  Name.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }
}

class ProviderOffer {
  String? id;
  Name? providerName;
  String? providerImage;
  String? providerCover;
  Name? description;
  String? createdAt;
  int? totalReviews;
  int? reviewCount;

  ProviderOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'] != null
        ? new Name.fromJson(json['provider_name'])
        : null;
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    createdAt = json['createdAt'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
  }
}
