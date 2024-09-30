class CategoryProviderModel {
  final String? id;
  final ProviderLanguage? name;
  final String? image;
  final List<CategoryProvidersModelData>? providers;
  CategoryProviderModel({this.id, this.name, this.image, this.providers});
  factory CategoryProviderModel.fromJson(Map<String, dynamic> json) {
    return CategoryProviderModel(
      id: json['id'],
      name: json['name'] != null
          ? ProviderLanguage.fromJson(json['name'])
          : null,
      image: json['image'],
      providers: json['providers'] != null
          ? List<CategoryProvidersModelData>.from(
              json['providers'].map((x) => CategoryProvidersModelData.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    if (providers != null) {
      data['providers'] = providers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryProvidersModelData {
  final String? id;
  final ProviderLanguage? providerName;
  final ProviderLocations? providerLocation;
  final String? providerImage;
  final String? providerCover;
  final ProviderLanguage? description;
  final int? totalReviews;
  final int? reviewCount;

  CategoryProvidersModelData(
      {this.id,
        this.providerName,
        this.providerLocation,
        this.providerImage,
        this.providerCover,
        this.description,
        this.totalReviews,
        this.reviewCount});
  factory CategoryProvidersModelData.fromJson(Map<String, dynamic> json) {
    return CategoryProvidersModelData(
      id: json['id'],
      providerName: json['provider_name'] != null
          ? ProviderLanguage.fromJson(json['provider_name'])
          : null,
      providerLocation: json['provider_location'] != null
          ? ProviderLocations.fromJson(json['provider_location'])
          : null,
      providerImage: json['provider_image'],
      providerCover: json['provider_cover'],
      description: json['description'] != null?
      ProviderLanguage.fromJson(json['description'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (providerName != null) {
      data['provider_name'] = providerName!.toJson();
    }
    if (providerLocation != null) {
      data['provider_location'] = providerLocation!.toJson();
    }
    data['provider_image'] = providerImage;
    data['provider_cover'] = providerCover;
    if (description != null) {
      data['description'] = description!.toJson();
    }
    return data;
  }
}
class ProviderLocations {
  final String? type;
  final List<int>? coordinates;

  const ProviderLocations({this.type, this.coordinates});
  factory ProviderLocations.fromJson(Map<String, dynamic> json) {
    return ProviderLocations(
      type: json['type'],
      coordinates: json['coordinates'].cast<int>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
class ProviderLanguage {
  final String? ar;
  final String? en;

  const ProviderLanguage({this.ar, this.en});
  factory ProviderLanguage.fromJson(Map<String, dynamic> json) {
    return ProviderLanguage(
      ar: json['ar'],
      en: json['en'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ar'] = ar;
    data['en'] = en;
    return data;
  }
}