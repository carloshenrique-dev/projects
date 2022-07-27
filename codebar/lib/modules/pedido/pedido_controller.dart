import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/info_lote_model.dart';
import 'package:up_codebar/app/core/models/pedido_model.dart';
import 'package:up_codebar/app/core/view_models/pedido/pedido_view_model.dart';
import 'package:up_codebar/app/ui/bottom_sheet/bottom_sheet_mixin.dart';
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';
import 'package:up_codebar/modules/lotes_abertos/lotes_abertos_controller.dart';

class PedidoController extends GetxController
    with LoaderMixin, MessagesMixin, BottomSheetMixin {
  final PedidoViewModel _pedidoViewModel;
  final LotesAbertosController _lotesAbertosController;
  var infoLoteModel = Rxn<InfoLoteModel>();
  final pedidos = <PedidoModel>[].obs;
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final bottomSheet = Rxn<BottomSheetModel>();

  PedidoController({
    required PedidoViewModel pedidoViewModel,
    required LotesAbertosController lotesAbertosController,
  })  : _lotesAbertosController = lotesAbertosController,
        _pedidoViewModel = pedidoViewModel;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    bottomSheetListener(bottomSheet);
    infoLoteModel(Get.arguments);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getPedidosLote();
  }

  Future<bool> getLotesAbertos() async {
    return await _lotesAbertosController.getLotesAbertos();
  }

  Future<bool> getPedidosLote() async {
    try {
      loading(true);
      final lista = await _pedidoViewModel.getPedidos(
          codLote: infoLoteModel.value!.codigo!);
      pedidos.assignAll(lista);
      loading(false);
      return true;
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'pedidoPageErro'.tr));
      return false;
    }
  }

  Future<void> limpaItem({required PedidoModel pedidoModel}) async {
    bottomSheet(
      BottomSheetModel(
        onConfirm: () async {
          loading(true);
          try {
            var retorno = await deleteItensLote(pedidoModel: pedidoModel);
            if (retorno.codRetorno == 0) {
              loading(false);
              message(MessageModel.error(message: 'barcodeErroLimpeza'.tr));
            } else if (retorno.codRetorno == 1) {
              await getPedidosLote();
              loading(false);
              Get.back();
              message(MessageModel.sucess(message: 'barcodeSucessoLimpeza'.tr));
            } else {
              loading(false);
              message(MessageModel.error(message: 'barcodeErroLimpeza'.tr));
            }
          } catch (e) {
            message(MessageModel.error(message: 'barcodeErroConferencia'.tr));
          }
        },
      ),
    );
  }

  //limpa a conferencia dos itens do pedido
  Future<DefaultReturnModel> deleteItensLote(
      {required PedidoModel pedidoModel}) async {
    try {
      loading(true);
      final retornoDelete = await _pedidoViewModel.deleteItensPedido(
        codPed: pedidoModel.codPed!,
      );
      loading(false);
      return DefaultReturnModel(
          codRetorno: retornoDelete.codRetorno,
          msgRetorno: retornoDelete.msgRetorno);
    } catch (e) {
      loading(false);
      return DefaultReturnModel(codRetorno: 0, msgRetorno: 'serverError'.tr);
    }
  }
}
