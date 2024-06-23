import 'package:flutter/material.dart';
import 'package:pos_mvp/model/order.dart';
import 'package:pos_mvp/model/product.dart';
import 'package:pos_mvp/page/cart/cart_presenter.dart';
import 'package:pos_mvp/page/cart/cart_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return CartPageState();
  }
}

class CartPageState extends State<CartPage> implements CartView {
  late CartPresenter _presenter;
  Order? _ongoingOrder;
  List<Product>? _products;
  bool _isLoading = false;
  TextEditingController _customerNameController = TextEditingController();

  CartPageState() {
    _presenter = CartPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    if (_products == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Segari POS"),
      ),
      body: _createBody(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: null,
        child: _countOrderProducts(),
      ),
    );
  }

  Widget _countOrderProducts() {
    if (_ongoingOrder == null) {
      return Text("0");
    }
    if (_ongoingOrder!.orderProducts == null || _ongoingOrder!.orderProducts!.isEmpty) {
      return Text("0");
    }
    final totalQuantity = _ongoingOrder!.orderProducts!.map((e) => e.quantity).reduce((value, element) => value! + element!);
    return Text("${totalQuantity}");
  }

  Widget _createBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(controller: _customerNameController,),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          children: _createProductsWidget(),
        ),
      ],
    );
  }

  @override
  void refreshOrder(Order? order) {
    setState(() {
      _ongoingOrder = order;
    });
  }

  @override
  void refreshProduct(List<Product> products) {
    setState(() {
      _products = products;
    });
  }

  List<Widget> _createProductsWidget() {
    return _products!
        .map((e) => GestureDetector(
              onTapUp: (_) => _productCardOnTap(e),
              child: Card(
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Text(
                        e.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("Rp.${e.price}"),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  void initialize(List<Product> products, Order? ongoingOrder) {
    setState(() {
      _products = products;
      _ongoingOrder = ongoingOrder;
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void setLoading(bool isLoading) {
    setState(() {
      isLoading = isLoading;
    });
  }

  _productCardOnTap(Product e) {
    _presenter.createOngoingOrder(_customerNameController.value.text);
    _presenter.addProduct(e);
  }
}
