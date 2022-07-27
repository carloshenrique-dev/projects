import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'customizations_bindings.dart';
import 'customizations_page.dart';

class CustomizationsModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/customizations',
      page: () => const CustomizationsPage(),
      binding: CustomizationsBindings(),
    )
  ];
}
