class Advertising {
  List<Data>? data;
  int? count;

  Advertising.fromJson(Map<String, dynamic> json) {
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
  Name? name;
  String? image;
  Provider? provider;
  List<Branches>? branches;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    image = json['image'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
  }
}

class Name {
  String? ar;
  String? en;

  Name.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }
}

class Provider {
  String? id;
  Name? providerName;
  String? providerImage;
  String? providerCover;
  Name? description;
  String? createdAt;
  int? totalReviews;
  int? reviewCount;

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerName = json['provider_name'] != null
        ? new Name.fromJson(json['provider_name'])
        : null;
    providerImage = json['provider_image'];
    providerCover = json['provider_cover'];
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    createdAt = json['createdAt'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
  }
}

class Branches {
  String? id;
  Name? branchName;
  Location? location;
  String? approvalStatus;
  Null? rejectionNotes;
  Name? description;
  String? openTime;
  List<WorkDays>? workDays;
  String? closeTime;
  String? status;
  int? totalReviews;
  int? reviewCount;
  String? image;
  String? phoneNumber;

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branch_name'] != null
        ? new Name.fromJson(json['branch_name'])
        : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    approvalStatus = json['approval_status'];
    rejectionNotes = json['rejection_notes'];
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    openTime = json['openTime'];
    if (json['workDays'] != null) {
      workDays = <WorkDays>[];
      json['workDays'].forEach((v) {
        workDays!.add(new WorkDays.fromJson(v));
      });
    }
    closeTime = json['closeTime'];
    status = json['status'];
    totalReviews = json['totalReviews'];
    reviewCount = json['reviewCount'];
    image = json['image'];
    phoneNumber = json['phoneNumber'];
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

  DefaultMessage.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }
}