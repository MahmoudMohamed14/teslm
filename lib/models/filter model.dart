class FilterProviders {
  List<Data>? data;
  int? count;

  FilterProviders.fromJson(Map<String, dynamic> json) {
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
  FilterProviderLanguage? providerName;
  String? providerImage;
  String? providerCover;
  FilterProviderLanguage? description;
  String? createdAt;
  int? totalReviews;
  int? reviewCount;
  List<FilterCategories>? categories;
  List<Null>? branches;
  int? itemCount;
  int? categoryCount;
  int? branchesCount;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'] != null
        ? new FilterProviderLanguage.fromJson(json['provider_name'])
        : null;
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'] != null
        ? new FilterProviderLanguage.fromJson(json['description'])
        : null;
    createdAt = json['createdAt'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
    if (json['categories'] != null) {
      categories = <FilterCategories>[];
      json['categories'].forEach((v) {
        categories!.add(new FilterCategories.fromJson(v));
      });
    }
    itemCount = json['itemCount'];
    categoryCount = json['categoryCount'];
    branchesCount = json['branchesCount'];
  }
}

class FilterCategories {
  String? id;
  FilterProviderLanguage? name;
  String? image;

  FilterCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new FilterProviderLanguage.fromJson(json['name']) : null;
    image = json['image'];
  }
}
class FilterProviderLanguage {
  String? ar;
  String? en;

  FilterProviderLanguage.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }
}