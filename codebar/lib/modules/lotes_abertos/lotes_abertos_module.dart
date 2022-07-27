import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/lotes_abertos/lotes_abertos_bindings.dart';
import 'lotes_abertos_page.dart';

class LotesAbertosModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/lotesAbertos',
      page: () => const LotesAbertosPage(),
      binding: LotesAbertosBindings(),
    ),
  ];
}
