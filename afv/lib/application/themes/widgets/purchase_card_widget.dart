import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'expandable_card_widget.dart';

class PurchaseCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String subtitle2;

  const PurchaseCardWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.subtitle2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.161,
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: Get.height * 0.005,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: ExpandableCardWidget(
                  title: title,
                  subtitle: subtitle,
                  subtitle2: subtitle2,
                ))
          ],
        ),
      ),
    );
  }
}
