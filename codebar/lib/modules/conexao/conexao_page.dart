import 'dart:io';
import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/default_button_widget.dart';
import 'package:up_codebar/app/theme/widgets/logo_widget.dart';
import 'package:up_codebar/modules/conexao/conexao_controller.dart';
import 'package:up_codebar/app/theme/widgets/text_widget.dart';

class ConexaoPage extends GetView<ConexaoController> {
  const ConexaoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.15,
                      child: AnimatedCard(
                        direction: AnimatedCardDirection.bottom,
                        child: LogoWidget(
                          color: theme.brightness == Brightness.dark
                              ? AppColors.whiteColor
                              : AppColors.grayColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text.rich(
                      TextSpan(
                        text: '${'conexaoPageErro'.tr}\n',
                        style: Get.isDarkMode
                            ? AppTextStyles.cardTextLightBold
                            : AppTextStyles.cardTextDarkBold,
                        children: [
                          TextSpan(
                            text: '${'conexaoPageTexto'.tr}! '
                                '${'conexaoPageTexto2'.tr} 😁',
                            style: Get.isDarkMode
                                ? AppTextStyles.cardTextLight
                                : AppTextStyles.cardTextDark,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.40,
                    ),
                    SizedBox(
                      width: Get.width * 0.86,
                      height: Get.height * 0.08,
                      child: DefaultButtonWidget(
                        color: Get.isDarkMode
                            ? AppColors.whiteColor
                            : AppColors.grayColor,
                        text: 'conexaoPageAtualizar'.tr,
                        funcao: () => controller.connectionTest(),
                        style: Get.isDarkMode
                            ? AppTextStyles.cardTextDarkBold
                            : AppTextStyles.cardTextLightBold,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Center(
                      child: InkWell(
                          child: TextWidget(
                            text: 'conexaoPageSair'.tr,
                            style: Get.isDarkMode
                                ? AppTextStyles.cardTextLight
                                : AppTextStyles.cardTextDark,
                          ),
                          onTap: () => exit(0)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
