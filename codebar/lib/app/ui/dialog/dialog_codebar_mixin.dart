import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/default_button_widget.dart';

mixin DialogCodebarMixin on GetxController {
  void dialogListener(Rxn<DialogCodebarModel> message) {
    ever<DialogCodebarModel?>(message, (model) {
      if (model != null) {
        Get.dialog(
          Dialog(
            child: SizedBox(
              height: Get.height * 0.37,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width * 0.6,
                    height: Get.height * 0.08,
                    child: DropdownSearch<String>(
                      items: model.combo,
                      mode: Mode.MENU,
                      selectedItem: model.combo.firstWhere(
                          (element) => element == model.combo.first,
                          orElse: () => 'Carregando'),
                      popupElevation: 6,
                      dropdownBuilderSupportsNullItem: true,
                      onChanged: model.comboChanged,
                      maxHeight: Get.height * 0.2,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        mini: true,
                        onPressed: model.add,
                        child: Icon(
                          Icons.add,
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                        ),
                        backgroundColor:
                            Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      Obx(
                        () => Text(
                          '${model.qtd.value}',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        mini: true,
                        onPressed: model.remove,
                        child: Icon(
                          Icons.remove,
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                        ),
                        backgroundColor:
                            Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DefaultButtonWidget(
                        text: 'cancelar'.tr,
                        funcao: () => Get.back(),
                        style: Get.isDarkMode
                            ? AppTextStyles.cardTextLight
                            : AppTextStyles.cardTextDark,
                        color:
                            Get.isDarkMode ? Colors.transparent : Colors.white,
                      ),
                      DefaultButtonWidget(
                        text: 'confirmar'.tr,
                        funcao: () => model.onConfirm(),
                        style: AppTextStyles.cardTextLight,
                        color: AppColors.darkBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
          ),
        );
      }
    });
  }
}

class DialogCodebarModel {
  final VoidCallback onConfirm;
  final VoidCallback add;
  final VoidCallback remove;
  final dynamic qtd;
  final List<String> combo;
  final Function(String?)? comboChanged;
  DialogCodebarModel({
    required this.onConfirm,
    required this.add,
    required this.remove,
    required this.qtd,
    required this.combo,
    this.comboChanged,
  });
}
