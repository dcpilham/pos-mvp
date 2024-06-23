import 'package:pos_mvp/model/product.dart';

class Order {
  int? id;
  String? customerName;
  double? totalPrice;
  List<OrderProduct>? orderProducts = [];

  Order({this.id, this.customerName, this.totalPrice, this.orderProducts});
}

class OrderProduct {
  int? id;
  Product? product;
  int? quantity;

  OrderProduct({this.id, this.product, this.quantity});
}