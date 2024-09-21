class Categories {
  String? id;
  CategoryLanguage? name;
  String? image;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new CategoryLanguage.fromJson(json['name']) : null;
    image = json['image'];
}}
class CategoryLanguage {
  String? ar;
  String? en;

  CategoryLanguage.fromJson(Map<String, dynamic> json) {
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