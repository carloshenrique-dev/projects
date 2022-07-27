import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_images.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/default_button_widget.dart';
import 'connection_controller.dart';

class ConnectionPage extends GetView<ConnectionController> {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: Get.height * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                child: SizedBox(
                  height: Get.height * 0.365,
                  child: Image.asset(
                    theme.brightness == Brightness.dark
                        ? AppImages.connectionError
                        : AppImages.connectionErrorDark,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.12,
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Ooops! :/\n\n',
                        style: Get.isDarkMode
                            ? AppTextStyles.homeTitleWhite
                            : AppTextStyles.homeTitleDark,
                        children: [
                          TextSpan(
                            text: 'errorCone'.tr,
                            style: Get.isDarkMode
                                ? AppTextStyles.h3White
                                : AppTextStyles.h3Dark,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
          child: SizedBox(
            width: Get.width * 0.95,
            height: Get.height * 0.07,
            child: DefaultButtonWidget(
              color: AppColors.waterGreen,
              text: 'try'.tr,
              funcao: () async => controller.checkConnectivity(),
              style: AppTextStyles.buttonTextWhite,
            ),
          ),
        ),
      ),
    );
  }
}
