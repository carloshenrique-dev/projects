import 'package:get/get.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'devolution_page.dart';

class DevolutionModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(name: '/devolution', page: () => const DevolutionPage()),
  ];
}
