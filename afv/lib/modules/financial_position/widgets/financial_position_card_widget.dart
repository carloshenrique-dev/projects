import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/text_personalizable_widget.dart';
import 'package:up_afv/core/models/customers/financial_positions_items_model.dart';

class FinancialPositionCardWidget extends StatelessWidget {
  final FinancialPositionsItemsModel financialPosition;
  const FinancialPositionCardWidget({
    Key? key,
    required this.financialPosition,
  }) : super(key: key);

  String formatData(String data) {
    var convert = DateFormat('yyyy-M-ddTHH:mm:ss').parse(data);
    return DateFormat('dd/MM/yyyy').format(convert);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            //maxHeight: Get.height,
            maxWidth: Get.width * .6,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPersonalizableWidget(
                maxLines: 1,
                text:
                    '${'expiration'.tr} ${formatData(financialPosition.dueDate!)}',
                style: theme.brightness == Brightness.dark
                    ? AppTextStyles.h3White
                    : AppTextStyles.h3Dark,
              ),
              TextPersonalizableWidget(
                style: theme.brightness == Brightness.dark
                    ? AppTextStyles.prodDetailsHeadWhiteSmall
                    : AppTextStyles.prodDetailsHeadDarkSmall,
                text:
                    '${'issued'.tr} ${formatData(financialPosition.issueDate!)}',
                maxLines: 1,
              ),
              TextPersonalizableWidget(
                style: theme.brightness == Brightness.dark
                    ? AppTextStyles.prodDetailsHeadWhiteSmall
                    : AppTextStyles.prodDetailsHeadDarkSmall,
                text: 'Boleto: ${financialPosition.titleCode}',
                maxLines: 1,
              ),
              TextPersonalizableWidget(
                style: theme.brightness == Brightness.dark
                    ? AppTextStyles.prodDetailsHeadWhiteSmall
                    : AppTextStyles.prodDetailsHeadDarkSmall,
                text:
                    '${'installments'.tr} ${financialPosition.installment}/${financialPosition.installmentsQty}',
                maxLines: 1,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 0,
              color: AppColors.defaultGreen,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.01, vertical: Get.height * 0.006),
                child: TextPersonalizableWidget(
                  style: AppTextStyles.moneyTextWhite,
                  text: 'R\$ ${financialPosition.amountInstallment}',
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
