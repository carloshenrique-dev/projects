import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'filter_button_widget.dart';

class FilterRowWidget extends StatelessWidget {
  final String textButton1;
  final String textButton2;
  final String textButton3;
  final Color colorButton1;
  final Color colorButton2;
  final Color colorButton3;
  final VoidCallback func1;
  final VoidCallback func2;
  final VoidCallback func3;
  final TextStyle textStyle1;
  final TextStyle textStyle2;
  final TextStyle textStyle3;
  const FilterRowWidget({
    Key? key,
    required this.textButton1,
    required this.textButton2,
    required this.textButton3,
    required this.colorButton1,
    required this.colorButton2,
    required this.colorButton3,
    required this.func1,
    required this.func2,
    required this.func3,
    required this.textStyle1,
    required this.textStyle2,
    required this.textStyle3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: Get.height * 0.09,
          width: Get.width * 0.27,
          child: FilterButtonWidget(
            texto: textButton1,
            color: colorButton1,
            func: func1,
            textStyle: textStyle1,
          ),
        ),
        SizedBox(
          height: Get.height * 0.09,
          width: Get.width * 0.27,
          child: FilterButtonWidget(
            texto: textButton2,
            color: colorButton2,
            func: func2,
            textStyle: textStyle2,
          ),
        ),
        SizedBox(
          height: Get.height * 0.09,
          width: Get.width * 0.27,
          child: FilterButtonWidget(
            textStyle: textStyle3,
            texto: textButton3,
            color: colorButton3,
            func: func3,
          ),
        ),
      ],
    );
  }
}
