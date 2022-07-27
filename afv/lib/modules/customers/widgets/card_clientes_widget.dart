import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/core/models/customers/customers_model.dart';
import 'text_card_clientes_widget.dart';

class CardClienteWidget extends StatelessWidget {
  final CustomersModel model;
  final int? reordenateList;

  const CardClienteWidget({
    Key? key,
    required this.model,
    required this.reordenateList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      color: AppColors.softBlueCard,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width * 0.70,
              height: Get.height * 0.12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child:
                        returnReordenatedText(context: context, theme: theme),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget returnReordenatedText(
      {required BuildContext context, required ThemeData theme}) {
    if (reordenateList == 0) {
      return Column(
        children: [
          TextCardClientesWidget(
            text: model.commercialName?.toLowerCase().capitalizeFirst,
            style: AppTextStyles.prodDetailsHeadWhite,
          ),
          SizedBox(
            height: Get.height * 0.0035,
          ),
          TextCardClientesWidget(
            text: model.corporateName?.toLowerCase().capitalizeFirst,
            style: AppTextStyles.prodDetailsHeadWhiteSmall,
          ),
          TextCardClientesWidget(
            text: '${'codCli'.tr}${model.customerCode.toString()}',
            style: AppTextStyles.prodDetailsHeadWhiteSmall,
          ),
        ],
      );
    } else if (reordenateList == 1) {
      return Column(
        children: [
          TextCardClientesWidget(
            text: model.corporateName?.toLowerCase().capitalizeFirst,
            style: AppTextStyles.prodDetailsHeadWhite,
          ),
          SizedBox(
            height: Get.height * 0.0035,
          ),
          TextCardClientesWidget(
            text: model.commercialName?.toLowerCase().capitalizeFirst,
            style: AppTextStyles.prodDetailsHeadWhiteSmall,
          ),
          TextCardClientesWidget(
            text: '${'codCli'.tr}${model.customerCode.toString()}',
            style: AppTextStyles.prodDetailsHeadWhiteSmall,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          TextCardClientesWidget(
            text: '${'codCli'.tr}${model.customerCode.toString()}',
            style: AppTextStyles.prodDetailsHeadWhite,
          ),
          SizedBox(
            height: Get.height * 0.0035,
          ),
          TextCardClientesWidget(
            text: model.commercialName?.toLowerCase().capitalizeFirst,
            style: AppTextStyles.prodDetailsHeadWhiteSmall,
          ),
          TextCardClientesWidget(
            text: model.corporateName?.toLowerCase().capitalizeFirst,
            style: AppTextStyles.prodDetailsHeadWhiteSmall,
          ),
        ],
      );
    }
  }
}
