import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'navigate_page.dart';

class NavigateModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(name: '/navigate', page: () => const NavigatePage()),
  ];
}
