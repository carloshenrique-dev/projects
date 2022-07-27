import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class TitleTextWidget extends StatelessWidget {
  final String text;
  final int maxLines;
  const TitleTextWidget({
    Key? key,
    required this.text,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Get.isDarkMode
          ? AppTextStyles.productDetailsWhite
          : AppTextStyles.productDetailsDark,
      textAlign: TextAlign.start,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
