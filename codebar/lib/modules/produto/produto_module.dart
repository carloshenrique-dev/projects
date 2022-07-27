import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_codebar/app/modules/module.dart';
import 'package:up_codebar/modules/produto/produto_bindings.dart';
import 'package:up_codebar/modules/produto/produto_page.dart';

class ProdutoModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/produto',
      page: () => const ProdutoPage(),
      binding: ProdutoBindings(),
    ),
  ];
}
