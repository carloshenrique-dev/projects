import 'dart:io';
import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/default_button_widget.dart';
import 'package:up_codebar/app/theme/widgets/logo_widget.dart';
import 'package:up_codebar/app/theme/widgets/text_form_field_widget.dart';
import 'package:up_codebar/modules/auth/auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .07),
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width * 0.40,
                    height: Get.height * 0.20,
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
                    height: Get.height * 0.025,
                  ),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        AnimatedCard(
                          direction: AnimatedCardDirection.left,
                          child: TextFormFieldWidget(
                            hintText: 'idAuth'.tr,
                            controller: controller.controllerID,
                            icon: const Icon(Icons.person),
                            visibilidade: false,
                            revelaTexto: () {},
                            senha: false,
                            onChanged: (value) =>
                                controller.validateTextField(idCliente: value),
                            validator: controller.validateID,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            length: 8,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AnimatedCard(
                            direction: AnimatedCardDirection.left,
                            child: Obx(() {
                              return TextFormFieldWidget(
                                hintText: 'senha'.tr,
                                controller: controller.controllerSenhaID,
                                visibilidade: controller.visibilidade.value,
                                revelaTexto: () => controller.isSenhaVisivel(),
                                icon: const Icon(Icons.lock_outline),
                                senha: true,
                                onChanged: (value) =>
                                    controller.validateTextField(senha: value),
                                validator: controller.validateSenhaID,
                                onFieldSubmitted: (value) =>
                                    controller.doAuth(),
                              );
                            })),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  AnimatedCard(
                    direction: AnimatedCardDirection.right,
                    child: SizedBox(
                      width: Get.width,
                      height: Get.height * 0.08,
                      child: DefaultButtonWidget(
                        color: AppColors.darkBlue,
                        text: 'loginEntrar'.tr,
                        funcao: () => controller.doAuth(),
                        style: AppTextStyles.cardTextLightBold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  AnimatedCard(
                    direction: AnimatedCardDirection.right,
                    child: SizedBox(
                      width: Get.width,
                      height: Get.height * 0.08,
                      child: DefaultButtonWidget(
                        color: Get.isDarkMode
                            ? AppColors.whiteColor
                            : AppColors.grayColor,
                        text: 'loginSair'.tr,
                        funcao: () => exit(0),
                        style: Get.isDarkMode
                            ? AppTextStyles.cardTextDarkBold
                            : AppTextStyles.cardTextLightBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
