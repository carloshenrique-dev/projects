import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'customer_details_bindings.dart';
import 'customer_details_page.dart';

class CustomerDetailsModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
        name: '/customerdetails',
        page: () => const CustomerDetailsPage(),
        binding: CustomerDetailsBindings())
  ];
}
