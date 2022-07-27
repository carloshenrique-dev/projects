import 'package:up_afv/core/models/products/price_list_db_model.dart';
import 'package:up_afv/core/models/products/prod_model.dart';
import 'package:up_afv/core/models/products_order/products_order_model.dart';
import 'package:up_afv/core/repositories/products/products_repository.dart';
import './produtos_view_model.dart';

class ProductsViewModelImpl implements ProductsViewModel {
  final ProductsRepository _productsRepository;
  ProductsViewModelImpl({
    required ProductsRepository productsRepository,
  }) : _productsRepository = productsRepository;

  @override
  Future<void> getProdutos() => _productsRepository.getProdutos();

  @override
  Future<List<ProdModel>> queryProducts() =>
      _productsRepository.queryProducts();

  @override
  Future<void> getPricesList() => _productsRepository.getPricesList();

  @override
  Future<List<PriceListDbModel>> queryPricesList({required int productCode}) =>
      _productsRepository.queryPricesList(productCode: productCode);

  @override
  Future<List<ProductsOrderModel>> queryProductsOrder() => _productsRepository.queryProductsOrder();
}
