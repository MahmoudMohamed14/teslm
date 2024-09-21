class CustomerOrders {
  List<Data>? data;
  int? count;

  CustomerOrders.fromJson(Map<String, dynamic> json) {
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
  int? totalPrice;
  int? shippingPrice;
  int? subtotal;
  int? discount;
  dynamic coupon;
  dynamic location;
  String? status;
  int? serial;
  String? createdAt;
  String? updatedAt;
  String? customerNotes;
  List<Items>? items;
  Customer? customer;
  ProviderOrders ?providerOrders;
  DeliveryPartner? deliveryPartner;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['totalPrice'];
    shippingPrice = json['shippingPrice'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    coupon = json['coupon'];
    location = json['location'];
    status = json['status'];
    serial = json['serial'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    customerNotes = json['customerNotes'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new Customer.fromJson(json['provider'])
        : null;
    providerOrders = json['customer'] != null
        ? new ProviderOrders.fromJson(json['provider'])
        : null;
    deliveryPartner = json['deliveryPartner'] != null
        ? new DeliveryPartner.fromJson(json['deliveryPartner'])
        : null;
  }
}

class Items {
  String? id;
  int? quantity;
  String? image;
  int? price;
  Item? item;
  List<SelectedOptionGroups>? selectedOptionGroups;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    image = json['image'];
    price = json['price'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    if (json['selectedOptionGroups'] != null) {
      selectedOptionGroups = <SelectedOptionGroups>[];
      json['selectedOptionGroups'].forEach((v) {
        selectedOptionGroups!.add(new SelectedOptionGroups.fromJson(v));
      });
    }
  }
}
class Translate {
  String? ar;
  String? en;

  Translate.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

}
class Item {
  String? id;
  Translate? name;
  int? calories;
  int? price;
  int? discount;
  bool? topItem;
  String? image;
  Translate? description;

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Translate.fromJson(json['name']) : null;
    calories = json['calories'];
    price = json['price'];
    discount = json['discount'];
    topItem = json['top_item'];
    image = json['image'];
    description = json['description'] != null
        ? new Translate.fromJson(json['description'])
        : null;
  }
}

class SelectedOptionGroups {
  String? id;
  Translate? name;
  List<SelectedOption>? selectedOption;

  SelectedOptionGroups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Translate.fromJson(json['name']) : null;
    if (json['selectedOption'] != null) {
      selectedOption = <SelectedOption>[];
      json['selectedOption'].forEach((v) {
        selectedOption!.add(new SelectedOption.fromJson(v));
      });
    }
  }
}

class SelectedOption {
  String? id;
  int? price;
  Translate? name;
  String? image;
  SelectedOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'] != null ? new Translate.fromJson(json['name']) : null;
    image = json['image'];
  }
}

class Customer {
  String? id;
  String? name;
  String? email;
  Null? birthdate;
  String? phoneNumber;
  String? address;
  bool? isDeleted;

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    birthdate = json['birthdate'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    isDeleted = json['isDeleted'];
  }
}

class DeliveryPartner {
  String? id;
  String? name;
  String? phoneNumber;
  String? profilePhoto;
  String? city;
  String? district;
  String? residencyNumber;
  String? residencyPhoto;
  String? licenseNumber;
  String? licensePhoto;
  String? status;
  String? vehicleNumber;
  String? vehicleLicensePhoto;
  Null? currentLocation;
  bool? isAvailable;
  String? createdAt;
  int? totalReviews;
  int? reviewCount;

  DeliveryPartner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    profilePhoto = json['profilePhoto'];
    city = json['city'];
    district = json['district'];
    residencyNumber = json['residencyNumber'];
    residencyPhoto = json['residencyPhoto'];
    licenseNumber = json['licenseNumber'];
    licensePhoto = json['licensePhoto'];
    status = json['status'];
    vehicleNumber = json['vehicleNumber'];
    vehicleLicensePhoto = json['vehicleLicensePhoto'];
    currentLocation = json['currentLocation'];
    isAvailable = json['isAvailable'];
    createdAt = json['createdAt'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
  }
}
class ProviderOrders {
  String? id;
  Translate? providerName;
  String? providerImage;
  String? providerCover;
  Translate? description;
  String? createdAt;
  int? totalReviews;
  int? reviewCount;

  ProviderOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'] != null
        ? new Translate.fromJson(json['provider_name'])
        : null;
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'] != null
        ? new Translate.fromJson(json['description'])
        : null;
    createdAt = json['createdAt'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
  }
}