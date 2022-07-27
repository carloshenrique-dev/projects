import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'text_personalizable_widget.dart';

class SidebarCardWidget extends StatelessWidget {
  final String image;
  final String title;

  const SidebarCardWidget({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.08,
      width: Get.width,
      child: Card(
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image),
            TextPersonalizableWidget(
                style: AppTextStyles.textFieldTitleDark,
                text: title,
                maxLines: 1),
          ],
        ),
      ),
    );
  }
}
