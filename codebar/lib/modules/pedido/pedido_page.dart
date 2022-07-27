import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/info_lote_model.dart';
import 'package:up_codebar/modules/pedido/widgets/lote_info_widget.dart';
import 'pedido_controller.dart';
import 'widgets/card_pedido_widget.dart';

class PedidoPage extends GetView<PedidoController> {
  const PedidoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.getLotesAbertos(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.01,
                        horizontal: Get.width * 0.020),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.pedidos.length,
                      itemBuilder: (context, index) {
                        final pedidos = controller.pedidos[index];
                        return InkWell(
                          onDoubleTap: () =>
                              controller.limpaItem(pedidoModel: pedidos),
                          onTap: () => Get.toNamed(
                            '/itens_pedido',
                            arguments: InfoLoteModel(
                              codPed: pedidos.codPed,
                              codigo: controller.infoLoteModel.value!.codigo,
                              itinerario:
                                  controller.infoLoteModel.value!.itinerario,
                              veiculo: controller.infoLoteModel.value!.veiculo,
                            ),
                          ),
                          child: CardPedidoWidget(
                            pedido: pedidos,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              LoteInfoWidget(
                infoLoteModel: controller.infoLoteModel.value,
              )
            ],
          ),
        ),
      ),
    );
  }
}
