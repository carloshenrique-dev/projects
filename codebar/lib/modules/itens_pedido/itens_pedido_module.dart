import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/itens_pedido/itens_pedido_bindings.dart';
import 'package:up_codebar/modules/itens_pedido/itens_pedido_page.dart';

class ItensPedidoModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/itens_pedido',
      page: () => const ItensPedidoPage(),
      binding: ItensPedidoBindings(),
    )
  ];
}
