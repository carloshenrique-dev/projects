import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'products_bindings.dart';
import 'products_page.dart';

class ProductsModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/products',
      page: () => const ProductsPage(),
      binding: ProdutosBinding(),
    )
  ];
}
