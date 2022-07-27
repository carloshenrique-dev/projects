import 'package:up_afv/core/models/customers/customers_address_model.dart';
import 'package:up_afv/core/models/customers/financial_positions_items_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_items_model.dart';
import 'package:up_afv/core/models/customers/sales_customers_products_model.dart';

abstract class CustomersViewModel {
  Future<void> getCustomers();
  Future<List<CustomersAddressModel>> getCustomersAddress(int customerCode);
  Future<List<FinancialPositionsItemsModel>> getFinancialPosition(
      int customerCode);
  Future<void> getFinancialPositionData();
  Future<void> getCustomersSales();
  Future<List<SalesCustomersItemsModel>> getCustomersSalesItems(
      int customerCode);
  Future<List<SalesCustomersProductsModel>> getCustomersSalesProducts(
      int customerCode);
}
