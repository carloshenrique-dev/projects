import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/inventory/inventory_bindings.dart';
import 'inventory_page.dart';

class InventoryModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/inventory',
      page: () => const InventoryPage(),
      binding: InventoryBindings(),
    ),
  ];
}
