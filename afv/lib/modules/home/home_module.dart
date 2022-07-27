import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'package:up_afv/modules/home/home_bindings.dart';
import 'package:up_afv/modules/home/home_page.dart';

class HomeModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      binding: HomeBindings(),
    )
  ];
}
