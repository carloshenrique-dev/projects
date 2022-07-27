import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/erro/erro_bindings.dart';
import 'package:up_codebar/modules/erro/erro_page.dart';

class ErroModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/erro',
      page: () => const ErroPage(),
      binding: ErroBindings(),
    )
  ];
}
