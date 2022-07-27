import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';

class SimpleCardWidget extends StatelessWidget {
  final Map map;
  const SimpleCardWidget({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      color: AppColors.cardTransInventory,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.barcode,
              size: Get.height * 0.09,
              color: AppColors.whiteColor,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: Text(
                map['barcode'],
                style: AppTextStyles.cardTextLight,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Wrap(
              direction: Axis.vertical,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Lote: ${map['lote']} \n',
                    style: AppTextStyles.cardTextLight,
                    children: [
                      TextSpan(text: 'Cod. Prod: ${map['codProd']} \n'),
                      TextSpan(text: 'Val. : ${map['validade']}'),
                    ],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
