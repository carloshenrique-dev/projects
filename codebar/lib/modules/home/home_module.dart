import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/home/home_page.dart';

class HomeModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(name: '/home', page: () => const HomePage()),
  ];
}
