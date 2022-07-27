import 'package:up_afv/core/models/products/price_list_db_model.dart';
import 'package:up_afv/core/models/products/prod_model.dart';
import 'package:up_afv/core/models/products_order/products_order_model.dart';

abstract class ProductsViewModel {
  Future<void> getProdutos();
  Future<List<ProdModel>> queryProducts();
  Future<List<ProductsOrderModel>> queryProductsOrder();
  Future<void> getPricesList();
  Future<List<PriceListDbModel>> queryPricesList({required int productCode});
}
