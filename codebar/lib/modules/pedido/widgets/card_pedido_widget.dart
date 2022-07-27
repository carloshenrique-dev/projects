import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/pedido_model.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';

class CardPedidoWidget extends StatelessWidget {
  final PedidoModel? pedido;

  const CardPedidoWidget({
    Key? key,
    required this.pedido,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      color: theme.brightness == Brightness.dark
          ? AppColors.whiteColor
          : AppColors.grayColor,
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
                    text: '${pedido?.codPed} - ${pedido?.nomeFantasia}',
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.trailingBoldDark
                        : AppTextStyles.trailingBoldLight,
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
                    text: 'Status: ',
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.trailingRegularDark
                        : AppTextStyles.trailingRegularLight,
                    children: [
                      TextSpan(
                        text: '${pedido?.descricaoStatusPed}',
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.trailingBoldDark
                            : AppTextStyles.trailingBoldLight,
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
                    text: 'quantidade'.tr,
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.trailingRegularDark
                        : AppTextStyles.trailingRegularLight,
                    children: [
                      TextSpan(
                        text: '${pedido?.qtdItens}',
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.trailingBoldDark
                            : AppTextStyles.trailingBoldLight,
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
