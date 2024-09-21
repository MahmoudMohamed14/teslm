class Provider {
  List<Data>? data;
  int? count;

  Provider.fromJson(Map<String, dynamic> json) {
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
  ProviderName? providerName;
  String? providerImage;
  String? providerCover;
  ProviderName? description;
  String? createdAt;
  String? updatedAt;
  List<ProviderCategories>? categories;
  List<Branches>? branches;
  int? totalReviews;
  int? reviewCount;
  int? itemCount;
  int? categoryCount;
  int? branchesCount;

  Data.fromJson(Map<String, dynamic> json) {
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
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
    if (json['categories'] != null) {
      categories = <ProviderCategories>[];
      json['categories'].forEach((v) {
        categories!.add(new ProviderCategories.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
    itemCount = json['itemCount'];
    categoryCount = json['categoryCount'];
    branchesCount = json['branchesCount'];
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
}

class ProviderCategories {
  String? id;
  ProviderName? name;
  String? image;

  ProviderCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new ProviderName.fromJson(json['name']) : null;
    image = json['image'];
  }
}

class Branches {
  String? id;
  ProviderName? branchName;
  Location? location;
  ProviderName? description;

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branch_name'] != null
        ? new ProviderName.fromJson(json['branch_name'])
        : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
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