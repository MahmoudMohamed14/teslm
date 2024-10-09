class ProviderItemsMenu {
  final String? id;
  final ItemsLanguage? providerName;
  final String? providerImage;
  final String? providerCover;
  final ItemsLanguage? description;
  final String? createdAt;
  final int? totalReviews;
  final int? reviewCount;
  final List<Reviews>? reviews;
  final List<ItemsCategory>? categoriesItemsData;

  ProviderItemsMenu({
    this.id,
    this.providerName,
    this.providerImage,
    this.providerCover,
    this.description,
    this.createdAt,
    this.totalReviews,
    this.reviewCount,
    this.reviews,
    this.categoriesItemsData,
  });
  factory ProviderItemsMenu.fromJson(Map<String, dynamic> json) {
    return ProviderItemsMenu(
      id: json['id'],
      providerName: json['provider_name'] != null
          ? ItemsLanguage.fromJson(json['provider_name'])
          : null,
      providerImage: json['provider_image'],
      providerCover: json['provider_cover'],
      description: json['description'] != null
          ? ItemsLanguage.fromJson(json['description'])
          : null,
      createdAt: json['createdAt'],
      totalReviews: json['totalReviews'],
      reviewCount: json['reviewCount'],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((i) => Reviews.fromJson(i)).toList()
          : null,
      categoriesItemsData: json['items'] != null
          ? (json['items'] as List)
              .map((i) => ItemsCategory.fromJson(i))
              .toList()
          : null,
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
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (categoriesItemsData != null) {
      data['items'] = categoriesItemsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProviderLocation {
  final String? type;
  final List<double>? coordinates;

  ProviderLocation({this.type, this.coordinates});

  factory ProviderLocation.fromJson(Map<String, dynamic> json) {
    return ProviderLocation(
      type: json['type'],
      coordinates: json['coordinates']?.cast<double>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class ItemsLanguage {
  final String? ar;
  final String? en;

  const ItemsLanguage({this.ar, this.en});
  factory ItemsLanguage.fromJson(Map<String, dynamic> json) {
    return ItemsLanguage(
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

class Reviews {
  final String? id;
  final String? content;
  final int? rating;
  final String? createdAt;

  Reviews({this.id, this.content, this.rating, this.createdAt});
  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      id: json['id'],
      content: json['content'],
      rating: json['rating'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['rating'] = rating;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Items {
  final String? id;
  final ItemsLanguage? name;
  final int? calories;
  final double? price;
  final int? discount;
  final bool? topItem;
  final String? image;
  final int? reviewCount;
  final int? totalReviews;
  final List<Reviews>? reviews;
  final ItemsLanguage? description;
  final List<Null>? categories;
  final List<OptionGroups>? optionGroups;

  Items({
    this.id,
    this.name,
    this.calories,
    this.price,
    this.discount,
    this.topItem,
    this.image,
    this.totalReviews,
    this.reviewCount,
    this.reviews,
    this.description,
    this.categories,
    this.optionGroups,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      name: json['name'] != null ? ItemsLanguage.fromJson(json['name']) : null,
      calories: json['calories'],
      price: double.parse(json['price'].toString() ?? '0.0'),
      discount: json['discount'],
      topItem: json['top_item'],
      image: json['image'],
      totalReviews: json['totalReviews'],
      reviewCount: json['reviewCount'],
      optionGroups: json['optionGroups'] != null
          ? (json['optionGroups'] as List)
              .map((i) => OptionGroups.fromJson(i))
              .toList()
          : [],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((i) => Reviews.fromJson(i)).toList()
          : null,
      description: json['description'] != null
          ? ItemsLanguage.fromJson(json['description'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['calories'] = calories;
    data['price'] = price;
    data['discount'] = discount;
    data['top_item'] = topItem;
    data['image'] = image;
    data['totalReviews'] = totalReviews;
    data['reviewCount'] = reviewCount;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    return data;
  }
}

class ReviewsItems {
  final String? id;
  final String? content;
  final int? rating;
  final String? createdAt;
  final String? author;

  ReviewsItems(
      {this.id, this.content, this.rating, this.createdAt, this.author});
  factory ReviewsItems.fromJson(Map<String, dynamic> json) {
    return ReviewsItems(
      id: json['id'],
      content: json['content'],
      rating: json['rating'],
      createdAt: json['createdAt'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['rating'] = rating;
    data['createdAt'] = createdAt;
    data['author'] = author;
    return data;
  }
}

class ItemsCategory {
  final String? name;
  final String? id;
  final List<Items>? items;

  ItemsCategory({this.name, this.id, this.items});
  factory ItemsCategory.fromJson(Map<String, dynamic> json) {
    return ItemsCategory(
      name: json['name'],
      id: json['id'],
      items: json['items'] != null
          ? (json['items'] as List).map((i) => Items.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionGroups {
  final String? id;
  final bool? isMandatory;
  final int? maxSelections;
  final ItemsLanguage? name;
  final List<Options>? options;

  OptionGroups(
      {this.id, this.isMandatory, this.maxSelections, this.name, this.options});
  factory OptionGroups.fromJson(Map<String, dynamic> json) {
    return OptionGroups(
      id: json['id'],
      isMandatory: json['isMandatory'],
      maxSelections: json['maxSelections'],
      name: json['name'] != null ? ItemsLanguage.fromJson(json['name']) : null,
      options: json['options'] != null
          ? (json['options'] as List).map((i) => Options.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isMandatory'] = isMandatory;
    data['maxSelections'] = maxSelections;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  OptionGroups copyWith({
    String? id,
    bool? isMandatory,
    int? maxSelections,
    ItemsLanguage? name,
    List<Options>? options,
  }) {
    return OptionGroups(
      id: id ?? this.id,
      isMandatory: isMandatory ?? this.isMandatory,
      maxSelections: maxSelections ?? this.maxSelections,
      name: name ?? this.name,
      options: options ?? this.options,
    );
  }
}

class Options {
  bool isSelected;
  final String? id;
  final int? price;
  final ItemsLanguage? name;
  final String? image;
  final ExtraItem? extraItem;

  Options({
    this.isSelected = false,
    this.id,
    this.price,
    this.name,
    this.image,
    this.extraItem,
  });
  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      id: json['id'],
      price: json['price'],
      name: json['name'] != null ? ItemsLanguage.fromJson(json['name']) : null,
      image: json['image'],
      extraItem: json['extraItem'] != null
          ? ExtraItem.fromJson(json['extraItem'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    if (extraItem != null) {
      data['extraItem'] = extraItem?.toJson();
    }
    return data;
  }

  Options copyWith({
    bool? isSelected,
    String? id,
    int? price,
    ItemsLanguage? name,
    String? image,
    ExtraItem? extraItem,
  }) {
    return Options(
      isSelected: isSelected ?? this.isSelected,
      id: id ?? this.id,
      price: price ?? this.price,
      name: name ?? this.name,
      image: image ?? this.image,
      extraItem: extraItem ?? this.extraItem,
    );
  }
}

class ExtraItem {
  final String? id;
  final ItemsLanguage? name;
  final String? image;
  final int? price;

  ExtraItem({this.id, this.name, this.image, this.price});
  factory ExtraItem.fromJson(Map<String, dynamic> json) {
    return ExtraItem(
      id: json['id'],
      name: json['name'] != null ? ItemsLanguage.fromJson(json['name']) : null,
      image: json['image'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    data['price'] = price;
    return data;
  }

  ExtraItem copyWith({
    String? id,
    ItemsLanguage? name,
    String? image,
    int? price,
  }) {
    return ExtraItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }
}
