import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/default_button_widget.dart';
import 'package:up_afv/application/themes/widgets/text_form_field_widget.dart';
import 'package:up_afv/application/themes/widgets/text_personalizable_widget.dart';

mixin LoginMasterBottomSheetMixin on GetxController {
  void loginMasterListener(Rxn<LoginMasterBottomSheetModel> bottomSheetModel) {
    ever<LoginMasterBottomSheetModel?>(bottomSheetModel, (model) {
      if (model != null) {
        final ThemeData theme = Theme.of(model.context);
        Get.bottomSheet(
          SizedBox(
            width: Get.width,
            height: Get.height * 0.27,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: theme.brightness == Brightness.dark
                    ? AppColors.grayColor
                    : AppColors.whiteDefault,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .05, vertical: Get.height * .02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextPersonalizableWidget(
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.textFieldTitleWhite
                            : AppTextStyles.textFieldTitleDark,
                        text: 'ID Cliente',
                        maxLines: 1),
                    SizedBox(
                      width: Get.width * 0.9,
                      child: TextFormFieldWidget(
                        validator: model.validator,
                        hintText: 'Ex: 01234567',
                        controller: model.controller,
                        icon: const Icon(
                          Icons.person,
                          color: AppColors.waterGreen,
                        ),
                        visibilidade: false,
                        senha: false,
                        onChanged: model.onChanged,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        length: 8,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                      width: Get.width * 0.9,
                      child: DefaultButtonWidget(
                        funcao: () => model.onConfirm(),
                        text: 'confirm'.tr,
                        style: AppTextStyles.textFieldTitleWhite,
                        color: AppColors.softBlueCard,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}

class LoginMasterBottomSheetModel {
  final VoidCallback onConfirm;
  final BuildContext context;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  LoginMasterBottomSheetModel({
    required this.onConfirm,
    required this.context,
    required this.controller,
    required this.onChanged,
    this.validator,
  });
}
