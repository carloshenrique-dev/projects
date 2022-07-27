import 'dart:io';
import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/default_button_widget.dart';
import 'package:up_codebar/app/theme/widgets/logo_widget.dart';
import 'package:up_codebar/modules/login/login_controller.dart';
import '../../app/theme/widgets/text_form_field_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

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
                    height: Get.height * 0.01,
                  ),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                          icon: const Icon(Icons.person),
                          controller: controller.controllerUsuario,
                          senha: false,
                          visibilidade: false,
                          revelaTexto: () {},
                          hintText: 'usuario'.tr,
                          onChanged: (value) =>
                              controller.validateTextField(usuario: value),
                          validator: controller.validateUsuario,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Obx(() {
                          return TextFormFieldWidget(
                            icon: const Icon(Icons.lock_outline),
                            controller: controller.controllerSenha,
                            senha: true,
                            hintText: 'senha'.tr,
                            revelaTexto: () => controller.isSenhaVisivel(),
                            visibilidade: controller.visibilidade.value,
                            onChanged: (value) =>
                                controller.validateTextField(senha: value),
                            validator: controller.validateSenha,
                            onFieldSubmitted: (value) => controller.doLogin(),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.08,
                    child: DefaultButtonWidget(
                      color: AppColors.darkBlue,
                      text: 'loginEntrar'.tr,
                      funcao: () => controller.doLogin(),
                      style: AppTextStyles.cardTextLightBold,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  SizedBox(
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
