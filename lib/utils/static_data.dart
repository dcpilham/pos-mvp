import 'package:pos_mvp/model/order.dart';
import 'package:pos_mvp/model/product.dart';

class StaticData {
  static List<Product> products = [
    Product(id: 1, name: "Indomie Goreng 85 gr", price: 3100),
    Product(id: 2, name: "Indomie Mie Instan Soto 70 gr", price: 3100),
    Product(id: 3, name: "Champ Nugget Ayam 500 gr", price: 50000),
    Product(id: 4, name: "Champ Sosis Sapi Serbaguna 375 gr", price: 43100),
    Product(id: 5, name: "Pronas Kornet Sapi Kaleng 198 gr", price: 25800),
    Product(id: 6, name: "Pronas Kornet Sapi Kaleng 340 gr", price: 38700),
  ];

  static List<Order> orders = [
    Order(id: 1, customerName: "Fia", totalPrice: 81000, orderProducts: [
      OrderProduct(id: 1, product: products[2], quantity: 1),
      OrderProduct(id: 2, product: products[1], quantity: 10),
    ]),
    Order(id: 2, customerName: "Mahen", totalPrice: 244800, orderProducts: [
      OrderProduct(id: 1, product: products[4], quantity: 3),
      OrderProduct(id: 2, product: products[0], quantity: 5),
      OrderProduct(id: 3, product: products[2], quantity: 2),
    ]),
  ];

  static int productIdCounter = 7;
  static int orderIdCounter = 3;
  static int orderProductIdCounter = 4;
}