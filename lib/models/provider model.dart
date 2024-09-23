class Provider {
  List<Providers>? providers;
  List<CategoriesHome>? categories;

  Provider.fromJson(Map<String, dynamic> json) {
    if (json['providers'] != null) {
      providers = <Providers>[];
      json['providers'].forEach((v) {
        providers!.add(new Providers.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <CategoriesHome>[];
      json['categories'].forEach((v) {
        categories!.add(new CategoriesHome.fromJson(v));
      });
    }
  }
}

class Providers {
  String? id;
  ProviderName? providerName;
  String? providerImage;
  String? providerCover;
  ProviderName? description;
  String? createdAt;
  int? totalReviews;
  int? reviewCount;
  List<Items>? items;

  Providers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'] != null
        ? new ProviderName.fromJson(json['provider_name'])
        : null;
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'] != null
        ? new ProviderName.fromJson(json['description'])
        : null;
    createdAt = json['createdAt'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }
}

class ProviderName {
  String? ar;
  String? en;

  ProviderName({this.ar, this.en});

  ProviderName.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    data['en'] = this.en;
    return data;
  }
}

class Items {
  String? id;
  ProviderName? name;
  int? calories;
  int? price;
  int? discount;
  bool? topItem;
  String? approvalStatus;
  String? image;
  int? totalReviews;
  int? reviewCount;
  ProviderName? description;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name =
    json['name'] != null ? new ProviderName.fromJson(json['name']) : null;
    calories = json['calories'];
    price = json['price'];
    discount = json['discount'];
    topItem = json['top_item'];
    approvalStatus = json['approval_status'];
    image = json['image'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
    description = json['description'] != null
        ? new ProviderName.fromJson(json['description'])
        : null;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }
}

class WorkDays {
  Label? label;
  String? value;

  WorkDays({this.label, this.value});

  WorkDays.fromJson(Map<String, dynamic> json) {
    label = json['label'] != null ? new Label.fromJson(json['label']) : null;
    value = json['value'];
  }
}

class Label {
  Null? key;
  Null? ref;
  Type? type;
  Props? props;
  Null? nOwner;

  Label.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    ref = json['ref'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    props = json['props'] != null ? new Props.fromJson(json['props']) : null;
    nOwner = json['_owner'];
  }
}

class Type {
  String? displayName;

  Type.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
  }

}

class Props {
  String? id;
  List<DefaultMessage>? defaultMessage;

  Props({this.id, this.defaultMessage});

  Props.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['defaultMessage'] != null) {
      defaultMessage = <DefaultMessage>[];
      json['defaultMessage'].forEach((v) {
        defaultMessage!.add(new DefaultMessage.fromJson(v));
      });
    }
  }
}

class DefaultMessage {
  int? type;
  String? value;

  DefaultMessage({this.type, this.value});

  DefaultMessage.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }
}

class CategoriesHome {
  String? id;
  ProviderName? name;
  String? image;
  List<Providers>? providers;

  CategoriesHome.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name =
    json['name'] != null ? new ProviderName.fromJson(json['name']) : null;
    image = json['image'];
    if (json['providers'] != null) {
      providers = <Providers>[];
      json['providers'].forEach((v) {
        providers!.add(new Providers.fromJson(v));
      });
    }
  }
}

class ProvidersHome {
  String? id;
  ProviderName? providerName;
  String? providerImage;
  String? providerCover;
  ProviderName? description;
  int? totalReviews;
  int? reviewCount;
  int? orderCount;

  ProvidersHome.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'] != null
        ? new ProviderName.fromJson(json['provider_name'])
        : null;
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'] != null
        ? new ProviderName.fromJson(json['description'])
        : null;
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
    orderCount = json['orderCount'];
  }

}
