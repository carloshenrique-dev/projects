import 'package:up_afv/core/models/not_sale/not_sale_model.dart';

abstract class NotSaleRepository {
  Future<void> getNotSale();
  Future<List<NotSaleModel>> queryNotSale();
}
