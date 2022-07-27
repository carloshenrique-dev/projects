import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'lotes_abertos_controller.dart';
import 'widgets/card_lote_aberto_widget.dart';

class LotesAbertosPage extends GetView<LotesAbertosController> {
  const LotesAbertosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.010,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Text(
                  'lotesAbertosPageTitulo'.tr,
                  style: theme.brightness == Brightness.dark
                      ? AppTextStyles.lotesTitleWhite
                      : AppTextStyles.lotesTitleDark,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.01, horizontal: Get.width * 0.04),
              child: Divider(
                thickness: 1,
                height: 1,
                color: theme.brightness == Brightness.dark
                    ? AppColors.stroke
                    : AppColors.grayColor,
              ),
            ),
            Obx(() {
              return Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.lotesAbertos.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => controller.navigate(
                          arguments: Get.arguments,
                          parameters: {
                            'itinerario':
                                '${controller.lotesAbertos[index].itndes}',
                            'veiculo':
                                '${controller.lotesAbertos[index].veiculo}'
                          },
                          statusLote: controller.lotesAbertos[index].statusLote,
                          codLote: controller.lotesAbertos[index].codLote,
                        ),
                        child: CardLoteAbertoWidget(
                          lotesAbertosModel: controller.lotesAbertos[index],
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
