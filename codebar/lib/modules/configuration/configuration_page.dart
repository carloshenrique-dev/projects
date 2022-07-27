import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/default_button_widget.dart';
import 'package:up_codebar/app/theme/widgets/toggle_widget.dart';
import 'package:up_codebar/modules/configuration/configuration_controller.dart';
import 'package:up_codebar/modules/configuration/widgets/text_field_widget.dart';

class ConfigurationPage extends GetView<ConfigurationController> {
  const ConfigurationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: Text(
                    'settings'.tr,
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.lotesTitleWhite
                        : AppTextStyles.lotesTitleDark,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.01, horizontal: Get.width * 0.04),
                child: Divider(
                  thickness: 1,
                  height: 1,
                  color: theme.brightness == Brightness.dark
                      ? AppColors.stroke
                      : AppColors.grayColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'timeConnection'.tr,
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.cardTextLight
                        : AppTextStyles.cardTextDark,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: TextFieldWidget(
                  controller: controller.timer,
                  hintText: '0',
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'showCodebar'.tr,
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.cardTextLight
                        : AppTextStyles.cardTextDark,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.only(left: Get.width * .02),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ToggleWidget(
                      value: controller.visualizaCodebar.value,
                      onChanged: (value) =>
                          controller.alteraVisualizacaoCodebar(value!),
                    ),
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'animationIcon'.tr,
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.cardTextLight
                        : AppTextStyles.cardTextDark,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Obx(
                () {
                  return Padding(
                    padding: EdgeInsets.only(left: Get.width * .02),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ToggleWidget(
                        value: controller.visualAnimado.value,
                        onChanged: (value) =>
                            controller.alteraVisualizacaoAnimacao(value!),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'enableAmountControl'.tr,
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.cardTextLight
                        : AppTextStyles.cardTextDark,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Obx(
                () {
                  return Padding(
                    padding: EdgeInsets.only(left: Get.width * .02),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ToggleWidget(
                        value: controller.enableAmountControl.value,
                        onChanged: (value) =>
                            controller.changeAmountControl(value!),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04, vertical: Get.width * 0.03),
          child: SizedBox(
            width: Get.width * 0.95,
            height: Get.height * 0.08,
            child: DefaultButtonWidget(
              color:
                  Get.isDarkMode ? AppColors.whiteColor : AppColors.grayColor,
              text: 'save'.tr,
              funcao: () => controller.saveConfigs(),
              style: Get.isDarkMode
                  ? AppTextStyles.cardTextDarkBold
                  : AppTextStyles.cardTextLightBold,
            ),
          ),
        ),
      ),
    );
  }
}
