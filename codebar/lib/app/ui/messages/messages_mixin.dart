import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';

mixin MessagesMixin on GetxController {
  void messageListener(Rxn<MessageModel> message) {
    ever<MessageModel?>(message, (model) {
      if (model != null) {
        Get.snackbar(
          model.title,
          model.message,
          colorText: AppColors.whiteColor,
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: model.type.color(),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(bottom: 7, left: 10, right: 10, top: 7),
        );
      }
    });
  }
}

class MessageModel {
  final String title;
  final String message;
  final MessageType type;
  MessageModel({
    required this.title,
    required this.message,
    required this.type,
  });

  MessageModel.error({
    required this.message,
  })  : type = MessageType.error,
        title = 'erro'.tr;

  MessageModel.info({
    required this.title,
    required this.message,
  }) : type = MessageType.info;

  MessageModel.sucess({
    required this.message,
  })  : type = MessageType.info,
        title = 'sucesso'.tr;
}

enum MessageType { error, info }

extension MessageTypeExtension on MessageType {
  Color color() {
    switch (this) {
      case MessageType.error:
        return AppColors.redCard;
      case MessageType.info:
        return Colors.blue[200] ?? Colors.blue;
    }
  }
}
