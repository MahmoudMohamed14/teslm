class CustomerOrders {
  final List<Data>? data;
  final int? count;

  CustomerOrders({this.data, this.count});

  factory CustomerOrders.fromJson(Map<String, dynamic> json) {
    return CustomerOrders(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  final String? id;
  final int? totalPrice;
  final int? shippingPrice;
  final int? subtotal;
  final int? discount;
  final dynamic coupon;
  final dynamic location;
  final String? status;
  final int? serial;
  final String? createdAt;
  final String? updatedAt;
  final String? customerNotes;
  final List<Items>? items;
  final Customer? customer;
  final ProviderOrders ?providerOrders;
  final DeliveryPartner? deliveryPartner;

  Data({this.id, this.totalPrice, this.shippingPrice, this.subtotal,
    this.discount, this.coupon, this.location, this.status, this.serial,
    this.createdAt, this.updatedAt, this.customerNotes, this.items,
    this.customer, this.providerOrders, this.deliveryPartner});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      totalPrice: json['totalPrice'],
      shippingPrice: json['shippingPrice'],
      subtotal: json['subtotal'],
      discount: json['discount'],
      coupon: json['coupon'],
      location: json['location'],
      status: json['status'],
      serial: json['serial'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      customerNotes: json['customerNotes'],
      items: json['items'] != null
          ? (json['items'] as List).map((i) => Items.fromJson(i)).toList()
          : null,
      customer: json['customer'] != null
          ?  Customer.fromJson(json['customer'])
          : null,
      providerOrders: json['providerOrders'] != null
          ?  ProviderOrders.fromJson(json['providerOrders'])
          :null
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['totalPrice'] = totalPrice;
    data['shippingPrice'] = shippingPrice;
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    data['coupon'] = coupon;
    data['location'] = location;
    data['status'] = status;
    data['serial'] = serial;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['customerNotes'] = customerNotes;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (providerOrders != null) {
      data['providerOrders'] = providerOrders!.toJson();
    }
    if (deliveryPartner != null) {
      data['deliveryPartner'] = deliveryPartner!.toJson();
    }
    return data;
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
class Items {
  final String? id;
  final int? quantity;
  final String? image;
  final int? price;
  final Item? item;
  final List<SelectedOptionGroups>? selectedOptionGroups;

  Items(
      {this.id,
        this.quantity,
        this.image,
        this.price,
        this.item,
        this.selectedOptionGroups});
  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      quantity: json['quantity'],
      image: json['image'],
      price: json['price'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      selectedOptionGroups: json['selectedOptionGroups'] != null
          ? (json['selectedOptionGroups'] as List)
          .map((i) => SelectedOptionGroups.fromJson(i))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['image'] = image;
    data['price'] = price;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    if (selectedOptionGroups != null) {
      data['selectedOptionGroups'] =
          selectedOptionGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Translate {
  final String? ar;
  final String? en;

  const Translate({this.ar, this.en});
  factory Translate.fromJson(Map<String, dynamic> json) {
    return Translate(
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
class Item {
  final String? id;
  final Translate? name;
  final int? calories;
  final int? price;
  final int? discount;
  final bool? topItem;
  final String? image;
  final Translate? description;

  Item(
      {this.id,
        this.name,
        this.calories,
        this.price,
        this.discount,
        this.topItem,
        this.image,
        this.description});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'] != null ?  Translate.fromJson(json['name']) : null,
      calories: json['calories'],
      price: json['price'],
      discount: json['discount'],
      topItem: json['top_item'],
      image: json['image'],
      description: json['description'] != null
          ?  Translate.fromJson(json['description'])
          : null,
    );}

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
    if (description != null) {
      data['description'] = description!.toJson();
    }
    return data;
  }
}

class SelectedOptionGroups {
  final String? id;
  final Translate? name;
  final List<SelectedOption>? selectedOption;

  SelectedOptionGroups({this.id, this.name, this.selectedOption});
  factory SelectedOptionGroups.fromJson(Map<String, dynamic> json) {
    return SelectedOptionGroups(
      id: json['id'],
      name: json['name'] != null ? Translate.fromJson(json['name']) : null,
      selectedOption: json['selectedOption'] != null
          ? (json['selectedOption'] as List)
          .map((i) => SelectedOption.fromJson(i))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (selectedOption != null) {
      data['selectedOption'] = selectedOption!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelectedOption {
  final String? id;
  final int? price;
  final Translate? name;
  final String? image;

  SelectedOption({this.id, this.price, this.name, this.image});
  factory SelectedOption.fromJson(Map<String, dynamic> json) {
    return SelectedOption(
      id: json['id'],
      price: json['price'],
      name: json['name'] != null ? Translate.fromJson(json['name']) : null,
      image: json['image'],
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
    return data;
  }
}

class Customer {
  final String? id;
  final String? name;
  final String? email;
  final Null birthdate;
  final String? phoneNumber;
  final String? address;
  final bool? isDeleted;

  Customer(
      {this.id,
        this.name,
        this.email,
        this.birthdate,
        this.phoneNumber,
        this.address,
        this.isDeleted});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      birthdate: json['birthdate'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      isDeleted: json['isDeleted'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['birthdate'] = birthdate;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['isDeleted'] = isDeleted;
    return data;
  }
}

class DeliveryPartner {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? profilePhoto;
  final String? city;
  final String? district;
  final String? residencyNumber;
  final String? residencyPhoto;
  final String? licenseNumber;
  final String? licensePhoto;
  final String? status;
  final String? vehicleNumber;
  final String? vehicleLicensePhoto;
  final Location? currentLocation;
  final bool? isAvailable;
  final String? createdAt;
  final int? totalReviews;
  final int? reviewCount;


  DeliveryPartner(
      {this.id,
        this.name,
        this.phoneNumber,
        this.profilePhoto,
        this.city,
        this.district,
        this.residencyNumber,
        this.residencyPhoto,
        this.licenseNumber,
        this.licensePhoto,
        this.status,
        this.vehicleNumber,
        this.vehicleLicensePhoto,
        this.currentLocation,
        this.isAvailable,
        this.createdAt,
        this.totalReviews,
        this.reviewCount,

      });

  factory DeliveryPartner.fromJson(Map<String, dynamic> json) {
    return DeliveryPartner(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      profilePhoto: json['profilePhoto'],
      city: json['city'],
      district: json['district'],
      residencyNumber: json['residencyNumber'],
      residencyPhoto: json['residencyPhoto'],
      licenseNumber: json['licenseNumber'],
      licensePhoto: json['licensePhoto'],
      status: json['status'],
      vehicleNumber: json['vehicleNumber'],
      vehicleLicensePhoto: json['vehicleLicensePhoto'],
      currentLocation: json['currentLocation'],
      isAvailable: json['isAvailable'],
      createdAt: json['createdAt'],
      totalReviews: json['totalReviews'],
      reviewCount: json['reviewCount'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['profilePhoto'] = profilePhoto;
    data['city'] = city;
    data['district'] = district;
    data['residencyNumber'] = residencyNumber;
    data['residencyPhoto'] = residencyPhoto;
    data['licenseNumber'] = licenseNumber;
    data['licensePhoto'] = licensePhoto;
    data['status'] = status;
    data['vehicleNumber'] = vehicleNumber;
    data['vehicleLicensePhoto'] = vehicleLicensePhoto;
    data['currentLocation'] = currentLocation;
    data['isAvailable'] = isAvailable;
    data['createdAt'] = createdAt;
    return data;
  }
}
class ProviderOrders {
  final String? id;
  final Translate? providerName;
  final String? providerImage;
  final String? providerCover;
  final Translate? description;
  final String? createdAt;
  final int? totalReviews;
  final int? reviewCount;

  ProviderOrders(
      {this.id,
        this.providerName,
        this.providerImage,
        this.providerCover,
        this.description,
        this.createdAt,
        this.totalReviews,
        this.reviewCount});

  factory ProviderOrders.fromJson(Map<String, dynamic> json) {
    return ProviderOrders(
      id: json['id'],
      providerName: json['provider_name'] != null
          ?  Translate.fromJson(json['provider_name'])
          : null,
      providerImage: json['provider_image'],
      providerCover: json['provider_cover'],
      description: json['description'] != null
          ?  Translate.fromJson(json['description'])
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