import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/info_lote_model.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';

class LoteInfoWidget extends StatelessWidget {
  final InfoLoteModel? infoLoteModel;

  const LoteInfoWidget({
    Key? key,
    this.infoLoteModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        height: Get.height * 0.075,
        alignment: Alignment.bottomCenter,
        color: AppColors.grayColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.95,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    verticalDirection: VerticalDirection.up,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'lote'.tr,
                          style: AppTextStyles.bottomText,
                          children: [
                            TextSpan(
                              text:
                                  '${infoLoteModel?.codigo}. - ${infoLoteModel?.itinerario} - ${infoLoteModel?.veiculo}',
                              style: AppTextStyles.bottomText,
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
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
