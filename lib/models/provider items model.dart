class ProviderItemsMenu {
  String? id;
  ItemsLanguage? providerName;
  String? providerImage;
  String? providerCover;
  ItemsLanguage? description;
  String? createdAt;
  int? totalReviews;
  int? reviewCount;
  List<Reviews>? reviews;
  List<ItemsCategory>? CategoriesItemsData;
  List<Branches>? branches;
  ProviderItemsMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'] != null
        ? new ItemsLanguage.fromJson(json['provider_name'])
        : null;
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'] != null
        ? new ItemsLanguage.fromJson(json['description'])
        : null;
    createdAt = json['createdAt'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    if (json['items'] != null) {
      CategoriesItemsData = <ItemsCategory>[];
      json['items'].forEach((v) {
        CategoriesItemsData!.add(new ItemsCategory.fromJson(v));
      });
    }
  }
}

class ProviderLocation {
  String? type;
  List<double>? coordinates;

  ProviderLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'] != null && json['coordinates'] is List
        ? json['coordinates'].cast<double>()
        : null;
  }
}
class ItemsLanguage {
  String? ar;
  String? en;

  ItemsLanguage.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }
}
class Reviews {
  String? id;
  String? content;
  int? rating;
  String? createdAt;

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    rating = json['rating'];
    createdAt = json['createdAt'];
  }
}
class Branches {
  String? id;
  ItemsLanguage? branchName;
  ProviderLocation? location;
  ItemsLanguage? description;

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branch_name'] != null
        ? new ItemsLanguage.fromJson(json['branch_name'])
        : null;
    location = json['location'] != null
        ? new ProviderLocation.fromJson(json['location'])
        : null;
    description = json['description'] != null
        ? new ItemsLanguage.fromJson(json['description'])
        : null;
  }

}
class Items {
  String? id;
  ItemsLanguage? name;
  int? calories;
  int? price;
  int? discount;
  bool? topItem;
  String? image;
  ItemsLanguage? description;
  List<Null>? categories;
  List<OptionGroups>? optionGroups;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name=json['name'] != null ? new ItemsLanguage.fromJson(json['name']) : null;
    calories = json['calories'];
    price = json['price'];
    discount = json['discount'];
    topItem = json['top_item'];
    image = json['image'];
    description = json['description'] != null
        ? new ItemsLanguage.fromJson(json['description'])
        : null;

    if (json['optionGroups'] != null) {
      optionGroups = (json['optionGroups'] as List)
          .map((groupJson) => OptionGroups.fromJson(groupJson))
          .toList();
    } else {
      optionGroups = [];
    }
  }
}
class ItemsCategory {
  String? name;
  String? id;
  List<Items>? items;

  ItemsCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }
}
class OptionGroups {
  String? id;
  bool? isMandatory;
  int? maxSelections;
  ItemsLanguage? name;
  List<Options>? options;

  OptionGroups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isMandatory = json['isMandatory'];
    maxSelections = json['maxSelections'];
    name = json['name'] != null ? new ItemsLanguage.fromJson(json['name']) : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }
}

class Options {
  String? id;
  int? price;
  ItemsLanguage? name;
  String? image;
  ExtraItem? extraItem;

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'] != null ? new ItemsLanguage.fromJson(json['name']) : null;
    image = json['image'];
    extraItem = json['extraItem'] != null
        ? new ExtraItem.fromJson(json['extraItem'])
        : null;
  }
}

class ExtraItem {
  String? id;
  ItemsLanguage? name;
  String? image;
  int? price;

  ExtraItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new ItemsLanguage.fromJson(json['name']) : null;
    image = json['image'];
    price = json['price'];
  }
}