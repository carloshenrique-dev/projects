import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final Color color;
  final Icon icon;
  final TextStyle textStyles;
  final VoidCallback navigation;
  const CardWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.icon,
    required this.textStyles,
    required this.navigation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 5,
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              height: Get.height * 0.015,
            ),
            Text(
              title,
              style: textStyles,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onTap: navigation,
    );
  }
}
