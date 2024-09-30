class Categories {
  final String? id;
  final CategoryLanguage? name;
  final String? image;
  const Categories({this.id, this.name, this.image});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name:
          json['name'] != null ? CategoryLanguage.fromJson(json['name']) : null,
      image: json['image'],
    );
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
