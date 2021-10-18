class CategoryModel {
  String? picture, name;

  CategoryModel({required this.picture, required this.name});
  CategoryModel.fromJson(Map<String,dynamic> json){
    this.name = json['name'];
    this.picture = json['picture'];
  }
}