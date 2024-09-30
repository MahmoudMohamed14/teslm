class Advertising {
  final List<Data>? data;
  final int? count;

  Advertising({this.data, this.count});

  factory Advertising.fromJson(Map<String, dynamic> json) {
    return Advertising(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
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

class Data {
  final String? id;
  final DataTranslate? name;
  final String? image;
  final ProvidersOffer? provider;

  Data({this.id, this.name, this.image, this.provider});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'] != null
          ?  DataTranslate.fromJson(json['name'])
          : null,
      image: json['image'],
      provider: json['provider'] != null
          ?  ProvidersOffer.fromJson(json['provider'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] =name!.toJson();
    }
    data['image'] = image;
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    return data;
  }
}

class DataTranslate {
  final String? ar;
  final String? en;

  const DataTranslate({this.ar, this.en});
  factory DataTranslate.fromJson(Map<String, dynamic> json) {
    return DataTranslate(
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

class ProvidersOffer {
  final String? id;
  final DataTranslate? providerName;
  final String? providerImage;
  final String? providerCover;
  final DataTranslate? description;
  final String? createdAt;
  final int? totalReviews;
  final int? reviewCount;

  ProvidersOffer(
      {this.id,
      this.providerName,
      this.providerImage,
      this.providerCover,
      this.description,
      this.createdAt,
      this.totalReviews,
      this.reviewCount});

  factory ProvidersOffer.fromJson(Map<String, dynamic> json) {
    return ProvidersOffer(
      id: json['id'],
      providerName: json['provider_name'] != null
          ? DataTranslate.fromJson(json['provider_name'])
          : null,
      providerImage: json['provider_image'],
      providerCover: json['provider_cover'],
      description: json['description'] != null
          ? DataTranslate.fromJson(json['description'])
          : null,
      createdAt: json['createdAt'],
      totalReviews: json['totalReviews'],
      reviewCount: json['reviewCount'],
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
    return data;
  }
}
