import 'package:get/get.dart';
import 'package:up_codebar/app/core/repositories/pedido/pedido_repository.dart';
import 'package:up_codebar/app/core/repositories/pedido/pedido_repository_impl.dart';
import 'package:up_codebar/app/core/view_models/pedido/pedido_view_model.dart';
import 'package:up_codebar/app/core/view_models/pedido/pedido_view_model_impl.dart';
import 'pedido_controller.dart';

class PedidoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PedidoRepository>(
        () => PedidoRepositoryImpl(apiServices: Get.find()),
        fenix: true);
    Get.lazyPut<PedidoViewModel>(
        () => PedidoViewModelImpl(pedidoRepository: Get.find()),
        fenix: true);
    Get.lazyPut<PedidoController>(
        () => PedidoController(
            pedidoViewModel: Get.find<PedidoViewModel>(),
            lotesAbertosController: Get.find()),
        fenix: true);
  }
}
