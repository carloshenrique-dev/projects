import 'package:get/get.dart';
import 'products_controller.dart';

class ProdutosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(
      () => ProductsController(
        productsViewModel: Get.find(),
        dbService: Get.find(),
      ),
      fenix: true,
    );
  }
}
