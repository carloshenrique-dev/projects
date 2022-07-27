import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/default_button_widget.dart';

mixin BottomSheetMixin on GetxController {
  void bottomSheetListener(Rxn<BottomSheetModel> bottomSheetModel) {
    ever<BottomSheetModel?>(bottomSheetModel, (model) {
      if (model != null) {
        Get.bottomSheet(
          Container(
            color: AppColors.grayColor,
            height: Get.height * 0.16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  'Deseja realizar a limpeza do item?'.tr,
                  style: AppTextStyles.cardTextLight,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DefaultButtonWidget(
                      text: 'cancelar'.tr,
                      funcao: () => Get.back(),
                      style: AppTextStyles.cardTextLight,
                      color: Colors.transparent,
                    ),
                    DefaultButtonWidget(
                      text: 'confirmar'.tr,
                      funcao: () => model.onConfirm(),
                      style: AppTextStyles.cardTextLight,
                      color: AppColors.darkBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}

class BottomSheetModel {
  final VoidCallback onConfirm;
  BottomSheetModel({
    required this.onConfirm,
  });
}
