import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/bottom_sheet_barcode_widget.dart';
import 'package:up_codebar/app/theme/widgets/simple_card_widget.dart';
import 'package:up_codebar/modules/generic_devolution/generic_devolution_controller.dart';

class GenericDevolutionPage extends GetView<GenericDevolutionController> {
  const GenericDevolutionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    controller.tipo = Get.arguments;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height * .805,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.010,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                    child: Text(
                      controller.returnTitle(),
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.lotesTitleWhite
                          : AppTextStyles.lotesTitleDark,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.01,
                      horizontal: Get.width * 0.04),
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: theme.brightness == Brightness.dark
                        ? AppColors.stroke
                        : AppColors.grayColor,
                  ),
                ),
                Obx(() {
                  return Flexible(
                    child: Visibility(
                      visible: controller.isCardVisible.value,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.035),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.devolutionList.length,
                            itemBuilder: (context, index) {
                              return SimpleCardWidget(
                                map: controller.devolutionList[index],
                              );
                            }),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
        bottomSheet: BottomSheetBarcodeWidget(
          autoFocus: false,
          focus: controller.focus,
          isToggleVisible: false,
          valueCheckBox: controller.valueCheckBox.value,
          isTextVisible: false,
          funcao: () => controller.scanBarCode(),
          hasText: controller.hasText.value,
          controller: controller.inputBarCode,
          conferenceFunction: () =>
              controller.conferenceFunction(controller.inputBarCode),
          onFieldSubmitted: (value) => controller.onFieldSubmitted(
              value: value, inputBarCode: controller.inputBarCode),
          onChanged: (value) => controller.onChanged(value),
          onChangedCheckBox: (value) => controller.onChangedCheckBox,
        ),
      ),
    );
  }
}
