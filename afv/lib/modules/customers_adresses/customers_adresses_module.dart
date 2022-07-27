import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'customers_adresses_bindings.dart';
import 'customers_adresses_page.dart';

class CustomersAdressesModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/customersadresses',
      page: () => const CustomersAdressesPage(),
      binding: CustomersAdressesBindings(),
    )
  ];
}
