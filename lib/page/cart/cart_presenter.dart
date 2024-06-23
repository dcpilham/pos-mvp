import 'package:get_it/get_it.dart';
import 'package:pos_mvp/model/order.dart';
import 'package:pos_mvp/model/product.dart';
import 'package:pos_mvp/page/cart/cart_view.dart';
import 'package:pos_mvp/repository/order.dart';
import 'package:pos_mvp/repository/product.dart';

class CartPresenter {
  // 1 to 1 mapping between presenter and page
  final CartView _view;

  // inject repository dependencies because they contain centralized data
  OrderRepository orderRepository = GetIt.I<OrderRepository>();
  ProductRepository productRepository = GetIt.I<ProductRepository>();

  CartPresenter(this._view);

  void initialize() async {
    _view.setLoading(true);
    var futures = await Future.wait([
      productRepository.getProducts(),
      orderRepository.getOngoingOrder()
    ]);

    _view.initialize(futures[0] as List<Product>, futures[1] as Order?);
  }

  void createOngoingOrder(String customerName) async {
    var ongoingOrder = orderRepository.createOngoingOrder(customerName);
    _view.refreshOrder(ongoingOrder);
  }

  void addProduct(Product e) async {
    Order? updatedOrder = await orderRepository.addOrderProduct(e);
    _view.refreshOrder(updatedOrder);
  }
}