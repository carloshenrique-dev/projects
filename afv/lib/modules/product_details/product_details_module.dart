import 'package:get/get.dart';
import 'package:up_afv/application/modules/modules.dart';
import 'product_details_bindings.dart';
import 'product_details_page.dart';

class ProductDetailsModule extends Modules {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/productdetails',
      page: () => const ProductDetailsPage(),
      binding: ProductDetailsBindings(),
    )
  ];
}
