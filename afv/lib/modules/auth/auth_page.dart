import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_images.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/default_button_widget.dart';
import 'package:up_afv/application/themes/widgets/text_form_field_widget.dart';
import './auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: Get.height * .05,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * .37,
                            child: Image.asset(
                              theme.brightness == Brightness.dark
                                  ? AppImages.logoAuth
                                  : AppImages.logoAuthDark,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Form(
                            onChanged: () => controller.isValidForm(),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'idClient'.tr,
                                  style: theme.brightness == Brightness.dark
                                      ? AppTextStyles.textFieldTitleWhite
                                      : AppTextStyles.textFieldTitleDark,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                TextFormFieldWidget(
                                  hintText: 'Ex: 00011334',
                                  controller: controller.controllerId,
                                  icon: const Icon(
                                    Icons.person,
                                    color: AppColors.waterGreen,
                                  ),
                                  visibilidade: false,
                                  senha: false,
                                  onChanged: (value) => controller
                                      .validateTextField(clientId: value),
                                  validator: controller.validateClientId,
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  length: 8,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  'sellerCode'.tr,
                                  style: theme.brightness == Brightness.dark
                                      ? AppTextStyles.textFieldTitleWhite
                                      : AppTextStyles.textFieldTitleDark,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                TextFormFieldWidget(
                                  hintText: 'Ex: 511',
                                  controller: controller.controllerSeller,
                                  icon: const Icon(
                                    Icons.person,
                                    color: AppColors.waterGreen,
                                  ),
                                  visibilidade: false,
                                  senha: false,
                                  onChanged: (value) =>
                                      controller.validateTextField(
                                          sellerCode: int.tryParse(value)),
                                  validator: controller.validateSellerCode,
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  'password'.tr,
                                  style: theme.brightness == Brightness.dark
                                      ? AppTextStyles.textFieldTitleWhite
                                      : AppTextStyles.textFieldTitleDark,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                TextFormFieldWidget(
                                  hintText: '********',
                                  controller: controller.controllerPassword,
                                  visibilidade: controller.visibilidade.value,
                                  revelaTexto: () {},
                                  icon: const Icon(
                                    Icons.lock_outline,
                                    color: AppColors.waterGreen,
                                  ),
                                  senha: true,
                                  onChanged: (value) => controller
                                      .validateTextField(password: value),
                                  validator: controller.validatePassword,
                                  onFieldSubmitted: (value) =>
                                      controller.doAuth(context),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          SizedBox(
                            width: Get.width,
                            height: Get.height * 0.07,
                            child: Obx(
                              () {
                                return DefaultButtonWidget(
                                  color: controller.isFormValid.value
                                      ? AppColors.waterGreen
                                      : AppColors.lightGray,
                                  funcao: () async =>
                                      await controller.doAuth(context),
                                  text: 'authenticate'.tr,
                                  style: AppTextStyles.buttonTextWhite,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
