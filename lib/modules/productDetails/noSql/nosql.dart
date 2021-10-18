import 'package:hive/hive.dart';

part 'nosql.g.dart';

@HiveType(typeId: 15)
class ProdcutModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? disc;
  @HiveField(3)
  String? details;
  @HiveField(4)
  String? size;
  @HiveField(5)
  String? color;
  @HiveField(6)
  String? pic;
  @HiveField(7)
  int? price;

  ProdcutModel(
      {required this.name,
      required this.pic,
      required this.disc,
      required this.price,
        required this.details,
        required this.size,
        required this.color,
        required this.id});

  ProdcutModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.pic = json['picture'];
    this.disc = json['disc'];
    this.price = json['price'];
    this.details = json['details'];
    this.size = json['size'];
    this.color = json['color'];
    this.id = json['id'];
  }

  Map<String, dynamic> toMap() => {
        'name': this.name,
        'picture': this.pic,
        'disc': this.disc,
        'price': this.price,
        'details': this.details,
        'size': this.size,
        'color': this.color,
        'id': this.id,
      };
}
