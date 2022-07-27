import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';

mixin DialogCustomizationMixin on GetxController {
  void dialogCustomizationListener(
      Rxn<DialogCustomizationModel> dialogCustomizationModel) {
    ever<DialogCustomizationModel?>(dialogCustomizationModel, (model) {
      if (model != null) {
        Get.bottomSheet(
          WillPopScope(
            onWillPop: () => model.scope!(),
            child: Container(
              height: Get.height * 0.19,
              color: AppColors.grayColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Insira a quantidade'.tr,
                    style: AppTextStyles.cardTextLight,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: Get.width * 0.90,
                    child: TextFormField(
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        labelText: '1.0',
                        labelStyle: AppTextStyles.captionBodyDark,
                        suffixIcon: Visibility(
                          visible: model.hasText,
                          child: IconButton(
                            onPressed: model.onConfirm,
                            icon: const Icon(
                              Icons.send,
                              color: AppColors.whiteColor,
                              size: 18,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: AppColors.orange,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: AppColors.icon,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: Get.width * 0.03),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: '1.0',
                      ),
                      controller: model.textController,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.captionBodyDark,
                      keyboardType: TextInputType.number,
                      onChanged: model.onChanged,
                      onFieldSubmitted: model.onFieldSubmitted,
                      focusNode: model.focus,
                      autofocus: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //isDismissible: false,
        );
      }
    });
  }
}

class DialogCustomizationModel {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final TextEditingController textController;
  final Function(String?) onFieldSubmitted;
  final Function(String)? onChanged;
  final FocusNode focus;
  final bool hasText;
  final Future<bool> Function()? scope;
  DialogCustomizationModel({
    required this.onConfirm,
    required this.onCancel,
    required this.textController,
    required this.onFieldSubmitted,
    required this.onChanged,
    required this.focus,
    required this.hasText,
    required this.scope,
  });
}
