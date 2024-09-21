class CategoryProviderModel {
  String? id;
  ProviderLanguage? name;
  String? image;
  List<CategoryProvidersModelData>? providers;

  CategoryProviderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new ProviderLanguage.fromJson(json['name']) : null;
    image = json['image'];
    if (json['providers'] != null) {
      providers = <CategoryProvidersModelData>[];
      json['providers'].forEach((v) {
        providers!.add(CategoryProvidersModelData.fromJson(v));
      });
    }
  }
}

class CategoryProvidersModelData {
  String? id;
  ProviderLanguage? providerName;
  ProviderLocations? providerLocation;
  String? providerImage;
  String? providerCover;
  ProviderLanguage? description;
  int? totalReviews;
  int? reviewCount;

  CategoryProvidersModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'] != null
        ? new ProviderLanguage.fromJson(json['provider_name'])
        : null;
    providerLocation = json['provider_location'] != null
        ? ProviderLocations.fromJson(json['provider_location'])
        : null;
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'] != null
        ? new ProviderLanguage.fromJson(json['description'])
        : null;
  }
}
class ProviderLocations {
  String? type;
  List<int>? coordinates;

  ProviderLocations.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }
}
class ProviderLanguage {
  String? ar;
  String? en;

  ProviderLanguage.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }
}