import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_colors.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/core/models/products/prod_model.dart';
import 'text_card_produto_widget.dart';

class CardProdutoWidget extends StatelessWidget {
  final bool visibility;
  final ProdModel model;
  final int? reordenateList;

  const CardProdutoWidget({
    Key? key,
    required this.visibility,
    required this.model,
    required this.reordenateList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      color: theme.brightness == Brightness.dark
          ? AppColors.whiteDefault
          : AppColors.grayColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.01,
          vertical: Get.height * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Get.width * 0.23,
              height: Get.height * 0.11,
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? AppColors.whiteDefault
                    : AppColors.grayColor,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image:
                      Image.memory(dataFromBase64String(model.imagem!)).image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            returnReordenatedText(context: context, theme: theme),
          ],
        ),
      ),
    );
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  Widget returnReordenatedText({
    required BuildContext context,
    required ThemeData theme,
  }) {
    if (reordenateList == 0) {
      return Column(
        children: [
          TextCardProdutoWidget(
            text: model.codProd.toString(),
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.prodDetailsHeadDark
                : AppTextStyles.prodDetailsHeadWhite,
            maxLines: 2,
          ),
          SizedBox(
            height: Get.height * 0.0035,
          ),
          TextCardProdutoWidget(
            text: '${'class2'.tr}${model.classe.toString()}',
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.prodDetailsHeadDarkSmall
                : AppTextStyles.prodDetailsHeadWhiteSmall,
            maxLines: 1,
          ),
          TextCardProdutoWidget(
            text: model.descricao ?? 'withoutDesc'.tr,
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.prodDetailsHeadDarkSmall
                : AppTextStyles.prodDetailsHeadWhiteSmall,
            maxLines: 2,
          ),
        ],
      );
    } else if (reordenateList == 1) {
      return Column(
        children: [
          TextCardProdutoWidget(
            text: model.classe?.toString() ?? 'withoutClass'.tr,
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.prodDetailsHeadDark
                : AppTextStyles.prodDetailsHeadWhite,
            maxLines: 2,
          ),
          SizedBox(
            height: Get.height * 0.0035,
          ),
          TextCardProdutoWidget(
            text: model.descricao ?? 'withoutDesc'.tr,
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.prodDetailsHeadDarkSmall
                : AppTextStyles.prodDetailsHeadWhiteSmall,
            maxLines: 2,
          ),
          TextCardProdutoWidget(
            text: '${'cod'.tr}: ${model.codProd.toString()}',
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.prodDetailsHeadDarkSmall
                : AppTextStyles.prodDetailsHeadWhiteSmall,
            maxLines: 1,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          TextCardProdutoWidget(
            text: model.descricao.toString().toLowerCase().capitalizeFirst!,
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.prodDetailsHeadDark
                : AppTextStyles.prodDetailsHeadWhite,
            maxLines: 2,
          ),
          SizedBox(
            height: Get.height * 0.0035,
          ),
          TextCardProdutoWidget(
            text: '${'class2'.tr}${model.classe.toString()}',
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.prodDetailsHeadDarkSmall
                : AppTextStyles.prodDetailsHeadWhiteSmall,
            maxLines: 1,
          ),
          TextCardProdutoWidget(
            text: '${'codCli'.tr}${model.codProd.toString()}',
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.prodDetailsHeadDarkSmall
                : AppTextStyles.prodDetailsHeadWhiteSmall,
            maxLines: 1,
          ),
        ],
      );
    }
  }
}
