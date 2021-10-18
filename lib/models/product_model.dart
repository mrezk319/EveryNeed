class ProdcutModel {
  String? pic, name, disc,details,size,color,id;
  int?price;

  ProdcutModel({required this.name, required this.pic,required this.disc,required this.price,details,size,color,id});
  ProdcutModel.fromJson(Map<String,dynamic> json){
    this.name = json['name'];
    this.pic = json['picture'];
    this.disc = json['disc'];
    this.price = json['price'];
    this.details = json['details'];
    this.size = json['size'];
    this.color = json['color'];
    this.id = json['id'];
  }
  Map<String,dynamic> toMap()=>{
    'name':this.name,
    'picture':this.pic,
    'disc':this.disc,
    'price':this.price,
    'details':this.details ,
    'size':this.size,
    'color':this.color,
    'id':this.id,
  };
}
