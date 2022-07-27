import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'customers_bindings.dart';
import 'customers_page.dart';

class CustomersModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
        name: '/customers',
        page: () => const CustomersPage(),
        binding: CustomersBindings())
  ];
}
