import 'package:up_afv/modules/about_client/about_client_module.dart';
import 'package:up_afv/modules/auth/auth_module.dart';
import 'package:up_afv/modules/connection/connection_module.dart';
import 'package:up_afv/modules/customers/customers_module.dart';
import 'package:up_afv/modules/customers_adresses/customers_adresses_module.dart';
import 'package:up_afv/modules/customers_details/customer_details_module.dart';
import 'package:up_afv/modules/customers_sales/customers_sales_module.dart';
import 'package:up_afv/modules/financial_position/financial_position_module.dart';
import 'package:up_afv/modules/home/home_module.dart';
import 'package:up_afv/modules/login/login_module.dart';
import 'package:up_afv/modules/product_details/product_details_module.dart';
import 'package:up_afv/modules/products/products_module.dart';
import 'package:up_afv/modules/sale_order/sale_order_module.dart';
import 'package:up_afv/modules/splash/splash_module.dart';

abstract class AppRoutes {
  static final routes = [
    ...ProductsModule().routers,
    ...CustomersModule().routers,
    ...HomeModule().routers,
    ...SplashModule().routers,
    ...AuthModule().routers,
    ...LoginModule().routers,
    ...ConnectionModule().routers,
    ...ProductDetailsModule().routers,
    ...CustomerDetailsModule().routers,
    ...FinancialPositionModule().routers,
    ...AboutClientModule().routers,
    ...CustomersSalesModule().routers,
    ...CustomersAdressesModule().routers,
    ...SaleOrderModule().routers,
  ];
}
