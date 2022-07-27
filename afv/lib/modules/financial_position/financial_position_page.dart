import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/widgets/title_list_text_widget.dart';
import 'package:up_afv/modules/financial_position/widgets/financial_position_card_widget.dart';
import './financial_position_controller.dart';

class FinancialPositionPage extends GetView<FinancialPositionController> {
  const FinancialPositionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.brightness == Brightness.dark
            ? AppColors.grayColor
            : AppColors.whiteColor,
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .01,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TitleListTextWidget(
                    text: 'posFin'.tr,
                  ),
                ),
                Divider(
                  color: theme.brightness == Brightness.dark
                      ? AppColors.whiteDefault
                      : AppColors.grayColor,
                  thickness: 0.7,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.list.length,
                    itemBuilder: (context, index) {
                      var financialPosition = controller.list[index];
                      return FinancialPositionCardWidget(
                        financialPosition: financialPosition,
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const Divider(
                        color: AppColors.body,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
