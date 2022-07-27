import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'customers_sales_page.dart';
//import 'customers_sales_bindings.dart';

class CustomersSalesModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/customersale',
      page: () => const CustomersSalesPage(),
      //binding: CustomersSalesBindings(),
    )
  ];
}
