import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/lotes_abertos_model.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/modules/lotes_abertos/lotes_abertos_controller.dart';

class CardLoteAbertoWidget extends GetView<LotesAbertosController> {
  final LotesAbertosModel lotesAbertosModel;

  const CardLoteAbertoWidget({Key? key, required this.lotesAbertosModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      color: controller.cardColor(lotesAbertosModel.statusLote),
      child: Row(
        children: [
          SizedBox(
            width: Get.width * 0.60,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.03, vertical: Get.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'lote'.tr,
                          style: AppTextStyles.trailingRegularLight,
                          children: [
                            TextSpan(
                              text:
                                  '${lotesAbertosModel.codLote} - ${lotesAbertosModel.itndes}',
                              style: AppTextStyles.trailingBoldLight,
                            ),
                          ],
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
                          text: 'veiculo'.tr,
                          style: AppTextStyles.trailingRegularLight,
                          children: [
                            TextSpan(
                              text: '${lotesAbertosModel.veiculo}',
                              style: AppTextStyles.trailingBoldLight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'pedidos'.tr,
                        style: AppTextStyles.trailingRegularLight,
                        children: [
                          TextSpan(
                            text: '${lotesAbertosModel.qtdPedidos}',
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
                        text: 'data'.tr,
                        style: AppTextStyles.trailingRegularLight,
                        children: [
                          TextSpan(
                            text: controller.formatData(lotesAbertosModel.data),
                            style: AppTextStyles.trailingBoldLight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
