import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_images.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/default_button_widget.dart';

mixin ChangeDeviceDialogMixin on GetxController {
  void dialogListener(Rxn<ChangeDeviceModel> message) {
    ever<ChangeDeviceModel?>(message, (model) {
      if (model != null) {
        Get.dialog(
          Dialog(
            child: SizedBox(
              height: Get.height * .5,
              width: Get.width * .085,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * .25,
                    child: Image.asset(
                      AppImages.changeDevice,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    'newDevice'.tr,
                    style: Get.isDarkMode
                        ? AppTextStyles.productDetailsWhite
                        : AppTextStyles.productDetailsDark,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: Get.width * 0.32,
                        height: Get.height * 0.065,
                        child: DefaultButtonWidget(
                          text: 'cancel'.tr,
                          funcao: () => model.onCancel(),
                          style: Get.isDarkMode
                              ? AppTextStyles.buttonTextDark
                              : AppTextStyles.buttonTextWhite,
                          color: Get.isDarkMode
                              ? AppColors.whiteDefault
                              : AppColors.grayColor,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.32,
                        height: Get.height * 0.065,
                        child: DefaultButtonWidget(
                          text: 'confirm'.tr,
                          funcao: () => model.onConfirm(),
                          style: AppTextStyles.buttonTextWhite,
                          color: AppColors.darkBlueCard,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        );
      }
    });
  }
}

class ChangeDeviceModel {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  ChangeDeviceModel({
    required this.onConfirm,
    required this.onCancel,
  });
}
