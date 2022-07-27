import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';

class MessageProvisorio {
  showMessage({required String message}) {
    Get.snackbar(
      'erro'.tr,
      message,
      colorText: AppColors.whiteColor,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(bottom: 7, left: 10, right: 10, top: 7),
    );
  }
}
