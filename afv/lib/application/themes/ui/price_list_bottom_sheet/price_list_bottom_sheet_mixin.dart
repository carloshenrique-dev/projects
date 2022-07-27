import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_images.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/application/themes/widgets/default_button_widget.dart';
import 'package:up_afv/application/themes/widgets/text_personalizable_widget.dart';

import 'package:up_afv/core/models/products/price_list_db_model.dart';
import 'package:up_afv/core/models/products/prod_model.dart';

mixin PriceListBottomSheetMixin on GetxController {
  void bottomSheetListener(Rxn<PriceListBottomSheetModel> bottomSheetModel) {
    ever<PriceListBottomSheetModel?>(bottomSheetModel, (model) {
      if (model != null) {
        final ThemeData theme = Theme.of(model.context);
        Get.bottomSheet(
          SizedBox(
            width: Get.width,
            height: Get.height * 0.4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: theme.brightness == Brightness.dark
                    ? AppColors.grayColor
                    : AppColors.whiteDefault,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: Get.height * 0.1,
                    width: Get.width * 0.2,
                    child: Image.asset(
                      AppImages.package,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  TextPersonalizableWidget(
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.textFieldTitleDetailsWhite
                          : AppTextStyles.textFieldTitleDetailsDark,
                      text: 'packaging'.tr,
                      maxLines: 1),
                  TextPersonalizableWidget(
                      style: theme.brightness == Brightness.dark
                          ? AppTextStyles.prodDetailsWhite
                          : AppTextStyles.textPriceListDetailsDark,
                      text:
                          '${model.prodModel.unidPdr} - 1 - R\$ ${model.priceListDbModel.salePrice!.toStringAsFixed(2)}',
                      maxLines: 1),
                  if (model.isFactorVisible)
                    TextPersonalizableWidget(
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.prodDetailsWhite
                            : AppTextStyles.textPriceListDetailsDark,
                        text:
                            '${model.prodModel.fatorUnid} - ${model.prodModel.fator} ${model.prodModel.unidPdr} - R\$ ${model.factor}',
                        maxLines: 1),
                  if (model.isPeVisible)
                    TextPersonalizableWidget(
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.prodDetailsWhite
                            : AppTextStyles.textPriceListDetailsDark,
                        text:
                            '${model.prodModel.peUnid} - ${model.prodModel.peQtd} ${model.prodModel.unidPdr} - R\$ ${model.pe}',
                        maxLines: 1),
                  SizedBox(
                    height: Get.height * 0.06,
                    width: Get.width * 0.9,
                    child: DefaultButtonWidget(
                      text: 'confirm'.tr,
                      funcao: () => Get.back(),
                      style: AppTextStyles.buttonTextWhite,
                      color: AppColors.softBlueCard,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}

class PriceListBottomSheetModel {
  final BuildContext context;
  final ProdModel prodModel;
  final PriceListDbModel priceListDbModel;
  final String factor;
  final String pe;
  final bool isPeVisible;
  final bool isFactorVisible;

  PriceListBottomSheetModel({
    required this.context,
    required this.prodModel,
    required this.priceListDbModel,
    required this.factor,
    required this.pe,
    required this.isPeVisible,
    required this.isFactorVisible,
  });
}
