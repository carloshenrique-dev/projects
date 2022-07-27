import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/bottom_sheet_barcode_widget.dart';
import 'package:up_codebar/app/theme/widgets/card_item_pedido_widget.dart';
import 'customizations_controller.dart';

class CustomizationsPage extends GetView<CustomizationsController> {
  const CustomizationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () => controller.getItensPedido(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .01,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Controle de Saldo',
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.lotesTitleWhite
                        : AppTextStyles.lotesTitleDark,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                Divider(
                  thickness: 1,
                  height: 1,
                  color: theme.brightness == Brightness.dark
                      ? AppColors.stroke
                      : AppColors.grayColor,
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                Obx(
                  () {
                    return SizedBox(
                      width: Get.width,
                      child: InkWell(
                        onDoubleTap: () => controller.limpaItem(
                            pedidoModel: controller.itemPedido.value!),
                        child: CardItemPedidoWidget(
                          itensPedidoModel: controller.itemPedido.value!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          bottomSheet: Obx(() {
            return BottomSheetBarcodeWidget(
              autoFocus: true,
              focus: controller.focus,
              isToggleVisible: true,
              isTextVisible: true,
              controller: controller.inputBarCode,
              infoLoteModel: controller.infoLoteModel.value,
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
