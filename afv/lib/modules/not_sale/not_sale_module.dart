import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'package:up_afv/modules/not_sale/not_sale_bindings.dart';
import 'package:up_afv/modules/not_sale/not_sale_page.dart';

class NotSaleModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
        name: '/notSale',
        page: () => const NotSalePage(),
        binding: NotSaleBindings())
  ];
}
