import 'package:up_afv/core/models/products/prod_model.dart';

class ProductsOrderModel {
  int quantity;
  ProdModel product;

  ProductsOrderModel({
    required this.quantity,
    required this.product,
  });
}
