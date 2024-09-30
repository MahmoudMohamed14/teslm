class ProviderHome {
  final List<Providers>? providers;
  List<CategoriesProvider>? categories;

  ProviderHome({this.providers,this.categories,});

  factory ProviderHome.fromJson(Map<String, dynamic> json) {
    return ProviderHome(
      providers: json['providers'] != null
          ? (json['providers'] as List)
              .map((i) => Providers.fromJson(i))
              .toList()
          : null,
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((i) => CategoriesProvider.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (providers != null) {
      data['providers'] = providers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class CategoriesProvider {
  final String? id;
  final ProviderName? name;
  final String? image;
  final List<Providers>? providers;

  CategoriesProvider({this.id, this.name, this.image, this.providers});

  factory CategoriesProvider.fromJson(Map<String, dynamic> json) {
    return CategoriesProvider(
      id: json['id'],
      name: json['name'] != null
          ? ProviderName.fromJson(json['name'])
          : null,
      image: json['image'],
      providers: json['providers'] != null
          ? (json['providers'] as List)
              .map((i) => Providers.fromJson(i))
              .toList()
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
class Providers {
  final String? id;
  final ProviderName? providerName;
  final String? providerImage;
  final String? providerCover;
  final ProviderName? description;
  final String? createdAt;
  final int? totalReviews;
  final int? reviewCount;

  Providers(
      {this.id,
      this.providerName,
      this.providerImage,
      this.providerCover,
      this.description,
      this.createdAt,
      this.totalReviews,
      this.reviewCount});

  factory Providers.fromJson(Map<String, dynamic> json) {
    return Providers(
      id: json['id'],
      providerName: json['provider_name'] != null
          ? ProviderName.fromJson(json['provider_name'])
          : null,
      providerImage: json['provider_image'],
      providerCover: json['provider_cover'],
      description: json['description'] != null
          ? ProviderName.fromJson(json['description'])
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

class ProviderName {
  final String? ar;
  final String? en;

  const ProviderName({this.ar, this.en});
  factory ProviderName.fromJson(Map<String, dynamic> json) {
    return ProviderName(
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

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: json['coordinates'].cast<double>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class WorkDays {
  final Label? label;
  final String? value;

  WorkDays({this.label, this.value});

  factory WorkDays.fromJson(Map<String, dynamic> json) {
    return WorkDays(
      label: json['label'] != null ?  Label.fromJson(json['label']) : null,
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (label != null) {
      data['label'] = label!.toJson();
    }
    data['value'] = value;
    return data;
  }
}

class Label {
  final Null key;
  final Null ref;
  final Type? type;
  final Props? props;
  final Null nOwner;

  Label({this.key, this.ref, required this.type, this.props, this.nOwner});

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      key: json['key'],
      ref: json['ref'],
      type: json['type'] != null ?  Type.fromJson(json['type']) : null,
      props: json['props'] != null ?  Props.fromJson(json['props']) : null,
      nOwner: json['_owner'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['ref'] = ref;
    if (type != null) {
      data['type'] = type?.toJson();
    }
    if (props != null) {
      data['props'] = props!.toJson();
    }
    data['_owner'] = nOwner;
    return data;
  }
}

class Type {
  final String? displayName;

  Type({this.displayName});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      displayName: json['displayName'],
    );
  }
    Map <String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    return data;}

}

class Props {
  final String? id;
  final List<DefaultMessage>? defaultMessage;

  Props({this.id, this.defaultMessage});

  factory Props.fromJson(Map<String, dynamic> json) {
    return Props(
      id: json['id'],
      defaultMessage: json['defaultMessage'] != null
          ? (json['defaultMessage'] as List)
              .map((i) => DefaultMessage.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (defaultMessage != null) {
      data['defaultMessage'] = defaultMessage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DefaultMessage {
  final int? type;
  final String? value;

  DefaultMessage({this.type, this.value});

  factory DefaultMessage.fromJson(Map<String, dynamic> json) {
    return DefaultMessage(
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}
