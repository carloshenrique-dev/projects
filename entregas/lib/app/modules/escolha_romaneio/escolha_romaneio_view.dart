import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/modules/escolha_romaneio/escolha_romaneio_controller.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/widgets/buttons/button_default.dart';

class EscolhaRomaneioView extends GetView<EscolhaRomaneioController> {
  const EscolhaRomaneioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: Get.height * 0.99,
            width: Get.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Wrap(
                    verticalDirection: VerticalDirection.up,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        '${controller.greetingMessage()}, ${'chooseRomaneio'.tr}',
                        textAlign: TextAlign.center,
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.title18
                            : AppTextStyles.title18Black,
                      )
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.015),
                Obx(() {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: Get.height * controller.listHeightSize.value,
                        minHeight: Get.height * 0.1),
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.listaRomaneios.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 6.0,
                            margin: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.013,
                                vertical: Get.height * 0.013),
                            child: Center(
                              child: Obx(() {
                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.05,
                                      vertical: Get.height * 0.0015),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  tileColor: controller.selectedIndex.value ==
                                          int.parse(controller
                                              .listaRomaneios[index]['romId'])
                                      ? AppColors.defaultGreen
                                      : Colors.transparent,
                                  title: Text(
                                    '${controller.listaRomaneios[index]['romId']} - ${controller.listaRomaneios[index]['itinerario']}',
                                    style: theme.brightness == Brightness.dark
                                        ? AppTextStyles.title16
                                        : AppTextStyles.title16Black,
                                    textAlign: TextAlign.center,
                                  ),
                                  onTap: () {
                                    controller.selectedIndex.value = int.parse(
                                        controller.listaRomaneios[index]
                                            ['romId']);
                                  },
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
                SizedBox(height: Get.height * 0.015),
                Expanded(
                  flex: 3,
                  child: Wrap(
                    verticalDirection: VerticalDirection.down,
                    direction: Axis.vertical,
                    alignment: WrapAlignment.start,
                    children: [
                      DefaultButton(
                        function: () => controller.validarDados(),
                        text: 'advance'.tr,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
