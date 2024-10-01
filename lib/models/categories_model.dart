class CategoriesModel {
  final String? id;
  final CategoryLanguage? name;
  final String? image;
  const CategoriesModel({this.id, this.name, this.image});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name:
          json['name'] != null ? CategoryLanguage.fromJson(json['name']) : null,
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

class CategoryLanguage {
  final String? ar;
  final String? en;

  const CategoryLanguage({this.ar, this.en});
  factory CategoryLanguage.fromJson(Map<String, dynamic> json) {
    return CategoryLanguage(
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
