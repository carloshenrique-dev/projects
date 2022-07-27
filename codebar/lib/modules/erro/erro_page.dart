import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_images.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/default_button_widget.dart';
import 'package:up_codebar/app/theme/widgets/text_widget.dart';
import 'package:up_codebar/modules/erro/erro_controller.dart';
import 'widgets/error_text_widget.dart';

class ErroPage extends GetView<ErroController> {
  const ErroPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return SizedBox(
                width: Get.width * 0.50,
                height: Get.height * 0.30,
                child: Image.asset(
                  controller.visualAnimado.value
                      ? AppImages.erroImage
                      : AppImages.erroDefault,
                  filterQuality: FilterQuality.high,
                ),
              );
            }),
            SizedBox(
              height: Get.height * 0.05,
            ),
            TextWidget(
              text: 'error'.tr,
              style: Get.isDarkMode
                  ? AppTextStyles.cardTextLightBold
                  : AppTextStyles.cardTextDarkBold,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            SizedBox(
              width: Get.width,
              child: ErrorTextWidget(
                text: Get.arguments ?? 'acaoInconclusiva'.tr,
                style: Get.isDarkMode
                    ? AppTextStyles.cardTextLight
                    : AppTextStyles.cardTextDark,
              ),
            ),
            SizedBox(
              height: Get.height * 0.075,
            ),
          ],
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
              text: 'voltar'.tr,
              funcao: () => Get.back(),
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
