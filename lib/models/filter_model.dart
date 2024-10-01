class FilterProvidersModel {
  final List<FilterDataModel>? data;
  final int? count;

  FilterProvidersModel({this.data, this.count});
  factory FilterProvidersModel.fromJson(Map<String, dynamic> json) {
    return FilterProvidersModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => FilterDataModel.fromJson(i)).toList()
          : null,
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class FilterDataModel {
  final String? id;
  final FilterProviderLanguage? providerName;
  final String? providerImage;
  final String? providerCover;
  final FilterProviderLanguage? description;
  final String? createdAt;
  final int? totalReviews;
  final int? reviewCount;
  final List<FilterCategories>? categories;
  final int? itemCount;
  final int? categoryCount;
  final int? branchesCount;


  FilterDataModel(
      {this.id,
      this.providerName,
      this.providerImage,
      this.providerCover,
      this.description,
      this.createdAt,
      this.totalReviews,
      this.reviewCount,
      this.categories,
      this.itemCount,
      this.categoryCount,
      this.branchesCount});

  factory FilterDataModel.fromJson(Map<String, dynamic> json) {
    return FilterDataModel(
      id: json['id'],
      providerName: json['provider_name'] != null
          ?  FilterProviderLanguage.fromJson(json['provider_name'])
          : null,
      providerImage: json['provider_image'],
      providerCover: json['provider_cover'],
      description: json['description'] != null
          ?  FilterProviderLanguage.fromJson(json['description'])
          : null,
      createdAt: json['createdAt'],
      totalReviews: json['totalReviews'],
      reviewCount: json['reviewCount'],
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((i) => FilterCategories.fromJson(i))
              .toList()
          : null,
      itemCount: json['itemCount'],
      categoryCount: json['categoryCount'],
      branchesCount: json['branchesCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (providerName != null) {
      data['provider_name'] = providerName!.toJson();
    }
    data['provider_image'] = providerImage;
    data['provider_cover'] = providerCover;
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['createdAt'] = createdAt;
    data['totalReviews'] = totalReviews;
    data['reviewCount'] = reviewCount;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    data['itemCount'] = itemCount;
    data['categoryCount'] = categoryCount;
    data['branchesCount'] = branchesCount;
    return data;
  }
}

class FilterCategories {
  final String? id;
  final FilterProviderLanguage? name;
  final String? image;

  FilterCategories({this.id, this.name, this.image});

  factory FilterCategories.fromJson(Map<String, dynamic> json) {
    return FilterCategories(
      id: json['id'],
      name: json['name'] != null
          ?  FilterProviderLanguage.fromJson(json['name'])
          : null,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    return data;
  }
}
class FilterProviderLanguage {
  final String? ar;
  final String? en;

  const FilterProviderLanguage({this.ar, this.en});
  factory FilterProviderLanguage.fromJson(Map<String, dynamic> json) {
    return FilterProviderLanguage(
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