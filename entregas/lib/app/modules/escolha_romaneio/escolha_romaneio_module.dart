import 'package:get/get.dart';
import 'package:upentregas/app/modulos/module.dart';
import 'escolha_romaneio_bindings.dart';
import 'escolha_romaneio_view.dart';

class EscolhaRomaneioModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/escolharomaneio',
      page: () => const EscolhaRomaneioView(),
      binding: EscolhaRomaneioBindings(),
    ),
  ];
}
