import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/widgets/bottom_sheet_button/bottom_sheet_button_widget.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          model.btnLeftTitle,
                          style: AppTextStyles.cardTextLight,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        BottomSheetButtonWidget(
                          funcao: () => model.btnFnLeft(),
                          color: model.colorBtnLeft,
                          icon: model.iconBtnLeft,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          model.btnRightTitle,
                          style: AppTextStyles.cardTextLight,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        BottomSheetButtonWidget(
                          funcao: () => model.btnFnRight(),
                          color: model.colorBtnRight,
                          icon: model.iconBtnRight,
                        ),
                      ],
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
  final VoidCallback btnFnLeft;
  final VoidCallback btnFnRight;
  final IconData iconBtnLeft;
  final IconData iconBtnRight;
  final Color colorBtnRight;
  final Color colorBtnLeft;
  final String btnLeftTitle;
  final String btnRightTitle;
  BottomSheetModel({
    required this.btnFnLeft,
    required this.btnFnRight,
    required this.iconBtnLeft,
    required this.iconBtnRight,
    required this.colorBtnRight,
    required this.colorBtnLeft,
    required this.btnLeftTitle,
    required this.btnRightTitle,
  });
}
