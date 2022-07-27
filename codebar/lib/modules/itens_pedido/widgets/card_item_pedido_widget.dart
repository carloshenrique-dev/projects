import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/itens_pedido_model.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';

class CardItemPedidoWidget extends StatelessWidget {
  final ItensPedidoModel itensPedidoModel;
  const CardItemPedidoWidget({
    Key? key,
    required this.itensPedidoModel,
  }) : super(key: key);

  Color cardColor() {
    if (itensPedidoModel.qtdConfFat == 0) {
      return AppColors.orange;
    } else if (itensPedidoModel.qtd == itensPedidoModel.qtdConfFat) {
      return AppColors.greenCard;
    } else {
      return AppColors.darkBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      color: cardColor(),
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
                    text: '${itensPedidoModel.descricao}',
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
                        text: '${itensPedidoModel.unid}',
                        style: AppTextStyles.trailingBoldLight,
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
                    text: 'EAN: ',
                    style: AppTextStyles.trailingRegularLight,
                    children: [
                      TextSpan(
                        text: '${itensPedidoModel.procodbar}',
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
                    text: 'cardItensQtd'.tr,
                    style: AppTextStyles.trailingRegularLight,
                    children: [
                      TextSpan(
                        text: '${itensPedidoModel.qtd}',
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
                        text: '${itensPedidoModel.qtdConfFat}',
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
