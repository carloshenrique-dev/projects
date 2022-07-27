import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_codebar/app/core/models/info_lote_model.dart';
import 'package:up_codebar/app/theme/widgets/bottom_sheet_barcode_widget.dart';
import './itens_pedido_controller.dart';
import '../../app/theme/widgets/card_item_pedido_widget.dart';

class ItensPedidoPage extends GetView<ItensPedidoController> {
  const ItensPedidoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.getPedidosLote(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: SizedBox(
                  height: Get.height * .77,
                  child: Column(
                    children: [
                      Obx(() => Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.01,
                                  horizontal: Get.width * 0.015),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controller.itemsPedido.length,
                                itemBuilder: (context, index) {
                                  final itemsPedido =
                                      controller.itemsPedido[index];
                                  return InkWell(
                                    onDoubleTap: () => controller.limpaItem(
                                        pedidoModel: itemsPedido),
                                    child: CardItemPedidoWidget(
                                      itensPedidoModel: itemsPedido,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: Obx(() {
            return BottomSheetBarcodeWidget(
          autoFocus: false,
              focus: controller.focus,
              isToggleVisible: true,
              isTextVisible: true,
              controller: controller.inputBarCode,
              infoLoteModel: InfoLoteModel(
                codigo: controller.infoLoteModel.value!.codigo,
                itinerario: controller.infoLoteModel.value!.itinerario,
                veiculo: controller.infoLoteModel.value!.veiculo,
                codPed: controller.infoLoteModel.value!.codPed,
              ),
              hasText: controller.hasText.value,
              conferenceFunction: () =>
                  controller.conferenceFunction(controller.inputBarCode),
              onFieldSubmitted: (value) => controller.onFieldSubmitted(
                  value: value, inputBarCode: controller.inputBarCode),
              onChanged: (value) => controller.onChanged(value),
              valueCheckBox: controller.valueCheckBox.value,
              onChangedCheckBox: (value) => controller.onChangedCheckBox(value),
              funcao: () => controller.scanBarcode(),
            );
          }),
        ),
      ),
    );
  }
}
