import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/produto_model.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/modules/produto/produto_controller.dart';

class CardProdutoWidget extends GetView<ProdutoController> {
  final ProdutoModel produtoModel;

  const CardProdutoWidget({
    Key? key,
    required this.produtoModel,
  }) : super(key: key);

  Color cardColor() {
    var resultado = produtoModel.qtd! +
        ((produtoModel.percToleranciaFc! / 100) * produtoModel.qtd!);
    if (produtoModel.qtdConfFat == 0) {
      return AppColors.orange;
    } else if (produtoModel.qtd == produtoModel.qtdConfFat ||
        (produtoModel.qtdConfFat! >= produtoModel.qtd! &&
            produtoModel.qtdConfFat! <= resultado)) {
      return AppColors.greenCard;
    } else {
      return AppColors.darkBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor(),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              direction: Axis.horizontal,
              children: [
                Text.rich(
                  TextSpan(
                    text: '${produtoModel.descricao}',
                    style: AppTextStyles.trailingBoldLight,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'cardItensUnid'.tr,
                    style: AppTextStyles.trailingRegularLight,
                    children: [
                      TextSpan(
                        text: '${produtoModel.unid}',
                        style: AppTextStyles.qtdBoldLight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Obx(() {
              return Visibility(
                visible: controller.visualizaCodebar.value,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'EAN: ',
                        style: AppTextStyles.trailingRegularLight,
                        children: [
                          TextSpan(
                            text: '${produtoModel.procodbar}',
                            style: AppTextStyles.trailingBoldLight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'cardItensQtd'.tr,
                    style: AppTextStyles.trailingRegularLight,
                    children: [
                      TextSpan(
                        text: '${produtoModel.qtd}',
                        style: AppTextStyles.qtdBoldLight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'cardItensQtdConf'.tr,
                    style: AppTextStyles.trailingRegularLight,
                    children: [
                      TextSpan(
                        text: '${produtoModel.qtdConfFat}',
                        style: AppTextStyles.qtdBoldLight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
