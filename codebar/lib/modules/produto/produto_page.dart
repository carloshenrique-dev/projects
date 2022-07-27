import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/info_lote_model.dart';
import 'package:up_codebar/app/theme/widgets/bottom_sheet_barcode_widget.dart';
import 'package:up_codebar/modules/produto/produto_controller.dart';
import 'widgets/card_produto_widget.dart';

class ProdutoPage extends GetView<ProdutoController> {
  const ProdutoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.codLote.value = Get.arguments;
    controller.itinerario.value = Get.parameters['itinerario']!;
    controller.veiculo.value = Get.parameters['veiculo']!;
    return WillPopScope(
      onWillPop: () => controller.getLotesAbertos(),
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: SizedBox(
                    height: Get.height * .763,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        Obx(
                          () => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.025),
                            child: DropdownSearch<String>(
                              items: controller.items,
                              enabled: true,
                              mode: Mode.MENU,
                              showSearchBox: true,
                              selectedItem: controller.items.firstWhere(
                                  (element) =>
                                      element == controller.items.first,
                                  orElse: () => 'produtoPageCarregando'.tr),
                              popupElevation: 6,
                              showAsSuffixIcons: true,
                              dropdownBuilderSupportsNullItem: true,
                              onChanged: (value) {
                                for (var i = 0;
                                    i < controller.combo.length;
                                    i++) {
                                  if (controller.combo[i].tipoSetor == value) {
                                    controller.tipo.value =
                                        controller.combo[i].tipo!;
                                    controller.getItensLote();
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        Obx(
                          () => Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.01,
                                  horizontal: Get.width * 0.015),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controller.itemsLote.length,
                                itemBuilder: (context, index) {
                                  final itemsLote = controller.itemsLote[index];
                                  return InkWell(
                                    onDoubleTap: () => controller.limpaItem(
                                        produtoModel: itemsLote),
                                    child: CardProdutoWidget(
                                      produtoModel: itemsLote,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
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
                isTextVisible: true,
                isToggleVisible: true,
                controller: controller.inputBarCode,
                infoLoteModel: InfoLoteModel(
                  codigo: controller.codLote.value,
                  itinerario: controller.itinerario.value,
                  veiculo: controller.veiculo.value,
                ),
                hasText: controller.hasText.value,
                conferenceFunction: () =>
                    controller.conferenceFunction(controller.inputBarCode),
                onFieldSubmitted: (value) => controller.onFieldSubmitted(
                    value: value, inputBarCode: controller.inputBarCode),
                onChanged: (value) => controller.onChanged(value),
                valueCheckBox: controller.valueCheckBox.value,
                onChangedCheckBox: (value) =>
                    controller.onChangedCheckBox(value),
                funcao: () => controller.scanBarcode(),
              );
            })),
      ),
    );
  }
}
