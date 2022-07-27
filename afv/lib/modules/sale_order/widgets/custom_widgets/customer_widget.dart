import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class CustomerWidget extends StatelessWidget {
  final String customer;
  const CustomerWidget({
    Key? key,
    required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Get.width * .71,
      height: Get.height * .07,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
        border: Border(),
        color: AppColors.lightGray,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          customer,
          style: AppTextStyles.ordersWhiteLabel,
          textAlign: TextAlign.left,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
