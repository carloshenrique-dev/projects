import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_images.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/default_button_widget.dart';
import 'package:up_afv/application/themes/widgets/text_form_field_widget.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * .37,
                          child: Image.asset(
                            theme.brightness == Brightness.dark
                                ? AppImages.logoLogin
                                : AppImages.logoLoginDark,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Form(
                          key: controller.formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: () => controller.isValidForm(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'user'.tr,
                                style: theme.brightness == Brightness.dark
                                    ? AppTextStyles.textFieldTitleWhite
                                    : AppTextStyles.textFieldTitleDark,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              TextFormFieldWidget(
                                hintText: 'UpSoftware',
                                controller: controller.controllerUser,
                                icon: const Icon(
                                  Icons.person,
                                  color: AppColors.waterGreen,
                                ),
                                visibilidade: false,
                                senha: false,
                                onChanged: (value) =>
                                    controller.validateTextField(user: value),
                                validator: controller.validateUser,
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
                                controller: controller.controllerSenha,
                                visibilidade: controller.visibilidade.value,
                                revelaTexto: () => controller.isSenhaVisivel(),
                                icon: const Icon(
                                  Icons.lock_outline,
                                  color: AppColors.waterGreen,
                                ),
                                senha: true,
                                onChanged: (value) => controller
                                    .validateTextField(password: value),
                                validator: controller.validatePassword,
                                onFieldSubmitted: (value) =>
                                    controller.doLogin(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: Get.height * 0.07,
                          child: Obx(() {
                            return DefaultButtonWidget(
                              color: controller.isFormValid.value
                                  ? AppColors.waterGreen
                                  : AppColors.lightGray,
                              funcao: () async => await controller.doLogin(),
                              text: 'enter'.tr,
                              style: AppTextStyles.buttonTextWhite,
                            );
                          }),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Obx(
                          () {
                            if (controller.preferences.isNotEmpty) {
                              return Visibility(
                                visible: controller.preferences[0].sellerCode !=
                                    null,
                                child: SizedBox(
                                  width: Get.width,
                                  height: Get.height * 0.07,
                                  child: DefaultButtonWidget(
                                    color: AppColors.red,
                                    funcao: () async =>
                                        await controller.doLogout(),
                                    text: 'logout'.tr,
                                    style: AppTextStyles.buttonTextWhite,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
