import 'package:pos_mvp/model/order.dart';
import 'package:pos_mvp/model/product.dart';

abstract class CartView {
  void refreshProduct(List<Product> products) {}
  void refreshOrder(Order? order) {}
  void setLoading(bool isLoading) {}
  void initialize(List<Product> products, Order? ongoingOrder) {}
}