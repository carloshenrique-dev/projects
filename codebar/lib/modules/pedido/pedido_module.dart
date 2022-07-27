import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/pedido/pedido_bindings.dart';
import 'pedido_page.dart';

class PedidoModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/pedido',
      page: () => const PedidoPage(),
      binding: PedidoBindings(),
    ),
  ];
}
