import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'package:up_afv/modules/sale_order/sale_order_bindings.dart';
import 'package:up_afv/modules/sale_order/sale_order_page.dart';

class SaleOrderModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/saleorder',
      page: () => const SaleOrderPage(),
      binding: SaleOrderBindings(),
    )
  ];
}
