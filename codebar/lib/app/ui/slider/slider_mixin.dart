import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/default_button_widget.dart';

mixin SliderMixin on GetxController {
  void bottomSheetSliderListener(Rxn<SliderModel> sliderModel) {
    ever<SliderModel?>(sliderModel, (model) {
      if (model != null) {
        Get.bottomSheet(
          Container(
            color: AppColors.grayColor,
            height: Get.height * 0.26,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  model.text,
                  style: AppTextStyles.cardTextLight,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: Get.height * 0.1,
                      width: Get.width * 0.1,
                      child: FloatingActionButton(
                        onPressed: model.remove,
                        child: Icon(
                          Icons.remove,
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                          size: 25,
                        ),
                        backgroundColor:
                            Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${model.label.value}',
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.1,
                      width: Get.width * 0.1,
                      child: FloatingActionButton(
                        onPressed: model.add,
                        child: Icon(
                          Icons.add,
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                          size: 25,
                        ),
                        backgroundColor:
                            Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DefaultButtonWidget(
                      text: 'cancelar'.tr,
                      funcao: () => model.onCancel(),
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

class SliderModel {
  final VoidCallback onConfirm;
  final VoidCallback add;
  final VoidCallback remove;
  final VoidCallback onCancel;
  final dynamic qtd;
  final String text;
  final dynamic label;
  //final bool isTextVisible;
  SliderModel({
    required this.onCancel,
    required this.label,
    required this.onConfirm,
    required this.add,
    required this.remove,
    required this.qtd,
    required this.text,
    //required this.isTextVisible,
  });
}
