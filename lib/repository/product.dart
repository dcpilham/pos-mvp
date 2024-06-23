import 'package:pos_mvp/model/product.dart';
import 'package:pos_mvp/utils/static_data.dart';

class ProductRepository {
  Future<List<Product>> getProducts() {
    return Future.value(StaticData.products);
  }
}