import 'package:flutter/material.dart';
import 'package:pos_mvp/model/order.dart';
import 'package:pos_mvp/model/product.dart';
import 'package:pos_mvp/utils/static_data.dart';

class OrderRepository extends ChangeNotifier {
  Order? _ongoingOrder;

  Order createOngoingOrder(String customerName) {
    if (_ongoingOrder == null) {
      _ongoingOrder = Order(id: StaticData.orderIdCounter++, customerName: customerName, orderProducts: []);
      return _ongoingOrder!;
    }
    return _ongoingOrder!;
  }

  Future<Order?> getOngoingOrder() {
    return Future.value(_ongoingOrder);
  }

  Future<Order?> createOrder() {
    if (_ongoingOrder != null) {
      StaticData.orders.add(_ongoingOrder!);
      final result = _ongoingOrder;
      _ongoingOrder = null;
      return Future.value(result);
    }
    return Future.value(null);
  }

  Future<List<Order>> getOrders() {
    return Future.value(StaticData.orders);
  }

  Future<Order?> addOrderProduct(Product newProduct) {
    if (_ongoingOrder == null) {
      return Future.value(null);
    }
    List<OrderProduct>? existingOrderProducts = _ongoingOrder!.orderProducts?.where((element) => element.product!.name == newProduct.name).toList();
    if (existingOrderProducts != null && existingOrderProducts.isNotEmpty) {
      OrderProduct existingOrderProduct = existingOrderProducts[0];
      existingOrderProduct.quantity =  existingOrderProduct.quantity! + 1;
    } else {
      _ongoingOrder?.orderProducts?.add(OrderProduct(id: StaticData.orderProductIdCounter++, product: newProduct, quantity: 1));
    }
    return Future.value(_ongoingOrder!);
  }
}