import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class DetailsCardWidget extends StatelessWidget {
  final double? containerSizeWidth;
  final double? containerSizeHeight;
  final String text1;
  final String text2;
  final String text3;
  final bool isVisible3Text;
  const DetailsCardWidget({
    Key? key,
    this.containerSizeWidth,
    this.containerSizeHeight,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.isVisible3Text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSizeWidth,
      height: containerSizeHeight,
      decoration: const BoxDecoration(
        color: AppColors.productDetailsColor,
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.009,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: Get.width,
                child: Text(
                  text1,
                  style: AppTextStyles.prodDetailsHeadWhite,
                  textAlign: TextAlign.start,
                  //maxLines: 1,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: Get.width,
                child: Text(
                  text2,
                  style: AppTextStyles.prodDetailsHeadWhite,
                  textAlign: TextAlign.start,
                  //maxLines: 1,
                ),
              ),
            ),
            Visibility(
              visible: isVisible3Text,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: Get.width,
                  child: Text(
                    text3,
                    style: AppTextStyles.prodDetailsHeadWhite,
                    textAlign: TextAlign.start,
                    //maxLines: 1,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
