import 'package:get/get.dart';
import 'package:up_codebar/app/core/repositories/barcode/barcode_repository.dart';
import 'package:up_codebar/app/core/repositories/barcode/barcode_repository_impl.dart';
import 'package:up_codebar/app/core/repositories/pedido/pedido_repository.dart';
import 'package:up_codebar/app/core/repositories/pedido/pedido_repository_impl.dart';
import 'package:up_codebar/app/core/view_models/barcode/barcode_view_model.dart';
import 'package:up_codebar/app/core/view_models/barcode/barcode_view_model_impl.dart';
import 'package:up_codebar/app/core/view_models/pedido/pedido_view_model.dart';
import 'package:up_codebar/app/core/view_models/pedido/pedido_view_model_impl.dart';
import './itens_pedido_controller.dart';

class ItensPedidoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeRepository>(
        () => BarcodeRepositoryImpl(apiServices: Get.find()),
        fenix: true);
    Get.lazyPut<BarcodeViewModel>(
        () => BarcodeViewModelImpl(barCodeRepository: Get.find()),
        fenix: true);
    Get.lazyPut<PedidoRepository>(
        () => PedidoRepositoryImpl(apiServices: Get.find()),
        fenix: true);
    Get.lazyPut<PedidoViewModel>(
        () => PedidoViewModelImpl(pedidoRepository: Get.find()),
        fenix: true);
    Get.lazyPut(
      () => ItensPedidoController(
        pedidoViewModel: Get.find(),
        barcodeViewModel: Get.find(),
        pedidoController: Get.find(),
        storage: Get.find(),
      ),
    );
  }
}
