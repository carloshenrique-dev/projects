import 'package:get/get.dart';
import 'package:upentregas/app/modules/fim_entrega/fim_entrega_bindings.dart';
import 'package:upentregas/app/modulos/module.dart';
import 'fim_entrega_view.dart';

class FimEntregaModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/fimentrega',
      page: () => const FimEntregaView(),
      binding: FimEntregaBindings(),
    ),
  ];
}
