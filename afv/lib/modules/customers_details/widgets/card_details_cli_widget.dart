import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class CardDetailsCliWidget extends StatelessWidget {
  final String text;
  const CardDetailsCliWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.waterGreen,
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.009,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: AppTextStyles.prodDetailsHeadWhite,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
