

import 'package:e_commerce/models/cart_model.dart';

class OrderModel {
  String? street1, street2, city, state, country, orderId, transType,time;
  int? totalPrice;
  List<CartModel> products = [];

  OrderModel(
      {required this.street1, required this.street2, required this.state, required this.city, required this.country, required this.transType, required this.orderId, required this.totalPrice, required this.products,required this.time});

  OrderModel.fromJson(Map<String, dynamic> json){
    this.street1 = json['street1'];
    this.street2 = json['street2'];
    this.city = json['city'];
    this.state = json['state'];
    this.country = json['country'];
    this.orderId = json['orderId'];
    this.transType = json['transType'];
    this.totalPrice = json['totalPrice'];
    this.time = json['time'];
    this.products.forEach((element) {
      json['products'].add(element.name);
    });
  }

  Map<String, dynamic> toMap() =>
      {
        'street1': this.street1,
        'street2': this.street2,
        'city': this.city,
        'state': this.state,
        'country': this.country,
        'orderId': this.orderId,
        'time': this.time,
        'transType': this.transType,
        'totalPrice': this.totalPrice,
        'products' : this.products.map((v) => v.toMap()).toList(),
      };
}
