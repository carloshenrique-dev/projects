import 'package:get/get.dart';
import 'package:up_codebar/app/core/repositories/barcode/barcode_repository.dart';
import 'package:up_codebar/app/core/repositories/barcode/barcode_repository_impl.dart';
import 'package:up_codebar/app/core/repositories/produto/produto_repository.dart';
import 'package:up_codebar/app/core/repositories/produto/produto_repository_impl.dart';
import 'package:up_codebar/app/core/view_models/barcode/barcode_view_model.dart';
import 'package:up_codebar/app/core/view_models/barcode/barcode_view_model_impl.dart';
import 'package:up_codebar/app/core/view_models/produto/produto_view_model.dart';
import 'package:up_codebar/app/core/view_models/produto/produto_view_model_impl.dart';
import 'package:up_codebar/modules/produto/produto_controller.dart';

class ProdutoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeRepository>(
        () => BarcodeRepositoryImpl(apiServices: Get.find()),
        fenix: true);
    Get.lazyPut<BarcodeViewModel>(
        () => BarcodeViewModelImpl(barCodeRepository: Get.find()),
        fenix: true);
    Get.lazyPut<ProdutoRepository>(
        () => ProdutoRepositoryImpl(apiServices: Get.find()),
        fenix: true);
    Get.lazyPut<ProdutoViewModel>(
        () => ProdutoViewModelImpl(produtoRepository: Get.find()),
        fenix: true);
    Get.lazyPut<ProdutoController>(
        () => ProdutoController(
              produtoViewModel: Get.find<ProdutoViewModel>(),
              barcodeViewModel: Get.find(),
              lotesAbertosController: Get.find(),
              storage: Get.find(),
            ),
        fenix: true);
  }
}
