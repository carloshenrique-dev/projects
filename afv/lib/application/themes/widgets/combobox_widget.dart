import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';
import 'package:up_afv/core/models/not_sale/not_sale_model.dart';
import 'text_personalizable_widget.dart';

class ComboboxWidget extends StatelessWidget {
  final List<NotSaleModel> notSaleModel;
  final RxString selected;

  const ComboboxWidget(
      {Key? key, required this.notSaleModel, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: Get.height * 0.062,
          width: Get.width,
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: DropdownButton(
                onChanged: (newValue) {
                  selected(newValue.toString());
                },
                value: selected.value,
                isExpanded: true,
                underline: const SizedBox(),
                items: notSaleModel.map((selectedType) {
                  return DropdownMenuItem(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                      child: TextPersonalizableWidget(
                          style: AppTextStyles.textFieldTitleWhite,
                          text:
                              '${selectedType.code.toString()} - ${selectedType.motive.toLowerCase().capitalizeFirst}',
                          maxLines: 1),
                    ),
                    value: selectedType.motive,
                  );
                }).toList(),
              ),
            ),
          ),
        ));
  }
}
