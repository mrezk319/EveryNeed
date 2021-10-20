class CategoryModel {
  String? picture, name,id;

  CategoryModel({required this.picture, required this.name,required this.id});
  CategoryModel.fromJson(Map<String,dynamic> json){
    this.name = json['name'];
    this.picture = json['picture'];
    this.id = json['id'];
  }
}