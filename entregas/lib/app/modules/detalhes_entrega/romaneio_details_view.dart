import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/modules/detalhes_entrega/romaneio_details_controller.dart';
import 'package:upentregas/app/modules/detalhes_entrega/widgets/indicador_widget.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/widgets/romaneio_button/elevated_button_widget.dart';

class RomaneioDetailsView extends GetView<RomaneioDetailsController> {
  const RomaneioDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 6,
            title: Text(
              controller.item!.cliente!['NomeFantasia'] ?? 'UpSoftware',
              style: AppTextStyles.title18,
            ),
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Obx(() {
                  controller.deliverieStep();
                  controller.formatDate(context);
                  return SizedBox(
                    height: Get.height * 0.20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.appSteps.length,
                      itemBuilder: (context, index) {
                        LineStyle beforeLineStyle = const LineStyle(
                          thickness: 20,
                          color: Color(0xFFD4D4D4),
                        );
                        LineStyle? afterLineStyle;
                        if (index <= controller.currentStep.value) {
                          beforeLineStyle = const LineStyle(
                            thickness: 20,
                            color: AppColors.defaultGreen,
                          );
                        }
                        if (index == controller.currentStep.value) {
                          afterLineStyle = const LineStyle(
                            thickness: 20,
                            color: Color(0xFFD4D4D4),
                          );
                        }
                        final isFirst = index == 0;
                        final isLast = index == controller.appSteps.length - 1;
                        num indicatorX = 0.5;
                        if (isFirst) {
                          indicatorX = 0.3;
                        } else if (isLast) {
                          indicatorX = 0.7;
                        }

                        return TimelineTile(
                          axis: TimelineAxis.horizontal,
                          alignment: TimelineAlign.manual,
                          lineXY: 0.65,
                          isFirst: isFirst,
                          isLast: isLast,
                          beforeLineStyle: beforeLineStyle,
                          afterLineStyle: afterLineStyle,
                          hasIndicator:
                              index <= controller.currentStep.value || isLast,
                          indicatorStyle: IndicatorStyle(
                            width: 30,
                            height: 30,
                            indicatorXY: indicatorX as double,
                            indicator: index <= controller.currentStep.value
                                ? const IndicatorApp()
                                : null,
                          ),
                          startChild: SizedBox(
                            width: Get.width * 0.325,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.appSteps[index],
                                  style: theme.brightness == Brightness.dark
                                      ? AppTextStyles.title15
                                      : AppTextStyles.title15Black,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          endChild: Container(
                            constraints: const BoxConstraints(minHeight: 5),
                          ),
                        );
                      },
                    ),
                  );
                }),
                Obx(() {
                  return SizedBox(
                    width: Get.width * 0.90,
                    height: Get.height < 890 &&
                            controller.detalhesDaEntrega['rotaEntrega'] == false
                        ? Get.height * 0.31
                        : Get.height * 0.425,
                    child: Center(
                      child: Text(
                        '${'adress'.tr}: \n${controller.item!.enderecoEntrega!['logradouro']}, ${controller.item!.enderecoEntrega!['numero']}, '
                        '${controller.item!.enderecoEntrega!['bairro']}, ${controller.item!.enderecoEntrega!['cidade']}-${controller.item!.enderecoEntrega!['UF']}\n'
                        '${'orderobs'.tr}: \n${controller.item!.obsPedido}, \nN* doc: ${controller.item!.codPed}\n\n',
                        textAlign: TextAlign.center,
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.title20
                            : AppTextStyles.title20Black,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
          bottomSheet: Obx(() {
            return SizedBox(
              height: controller.detalhesDaEntrega['rotaEntrega'] == true
                  ? Get.height * 0.115
                  : Get.height * 0.21,
              child: Column(
                children: [
                  Visibility(
                    visible: controller.detalhesDaEntrega['rotaEntrega'] == true
                        ? false
                        : true,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                      ),
                      child: SizedBox(
                        width: Get.width * 0.95,
                        height: Get.height * 0.093,
                        child: ElevatedButtonWidget(
                          funcao: () async => controller.navegacao(),
                          text: 'whereGoing'.tr,
                          color: AppColors.defaultGreen,
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if ((controller.detalhesDaEntrega['rotaEntrega'] == true &&
                            controller.detalhesDaEntrega['rotaEntrega'] !=
                                null) &&
                        (controller.detalhesDaEntrega['entregaConcluida'] ==
                                true &&
                            controller.detalhesDaEntrega['entregaConcluida'] !=
                                null)) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.02,
                            vertical: Get.height * 0.01),
                        child: SizedBox(
                          width: Get.width * 0.95,
                          height: Get.height * 0.093,
                          child: ElevatedButtonWidget(
                            funcao: () async =>
                                controller.reaberturaEntrega(context),
                            text: 'reopenDelivery'.tr,
                            color: AppColors.defaultGreen,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.03,
                            vertical: Get.height * 0.01),
                        child: SizedBox(
                          width: Get.width * 0.95,
                          height: Get.height * 0.093,
                          child: controller.detalhesDaEntrega['rotaEntrega'] ==
                                  true
                              ? ElevatedButtonWidget(
                                  funcao: () => controller.endDeliverie(),
                                  text: 'enddeliverie'.tr,
                                  color: AppColors.defaultGreen,
                                )
                              : ElevatedButtonWidget(
                                  funcao: () async =>
                                      controller.startDeliverie(),
                                  text: 'startdeliverie'.tr,
                                  color: AppColors.defaultGreen,
                                ),
                        ),
                      );
                    }
                  }),
                ],
              ),
            );
          })),
    );
  }
}
