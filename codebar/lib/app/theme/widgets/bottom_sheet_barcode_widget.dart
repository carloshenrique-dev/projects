import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:up_codebar/app/core/models/info_lote_model.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/theme/styles/app_text_styles.dart';
import 'package:up_codebar/app/theme/widgets/toggle_widget.dart';

class BottomSheetBarcodeWidget extends StatelessWidget {
  final InfoLoteModel? infoLoteModel;
  final TextEditingController? controller;
  final bool valueCheckBox;
  final bool hasText;
  final bool isTextVisible;
  final bool isToggleVisible;
  final VoidCallback funcao;
  final VoidCallback conferenceFunction;
  final Function(bool?)? onChangedCheckBox;
  final Function(String?) onChanged;
  final Function(String?) onFieldSubmitted;
  final FocusNode focus;
  final bool autoFocus;
  const BottomSheetBarcodeWidget({
    Key? key,
    this.infoLoteModel,
    this.controller,
    required this.valueCheckBox,
    this.hasText = false,
    required this.isTextVisible,
    required this.isToggleVisible,
    required this.funcao,
    required this.conferenceFunction,
    this.onChangedCheckBox,
    required this.onChanged,
    required this.onFieldSubmitted,
    required this.focus,
    required this.autoFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        height: isTextVisible ? Get.height * 0.19 : Get.height * 0.155,
        alignment: Alignment.bottomCenter,
        color: AppColors.grayColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: Get.width * 0.77,
                    child: TextFormField(
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        labelText: 'barcodeDigiteCodigo'.tr,
                        labelStyle: AppTextStyles.captionBodyDark,
                        suffixIcon: Visibility(
                          visible: hasText,
                          child: IconButton(
                            onPressed: conferenceFunction,
                            icon: const Icon(
                              Icons.send,
                              color: AppColors.whiteColor,
                              size: 18,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: AppColors.orange,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: AppColors.icon,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: Get.width * 0.03),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      controller: controller,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.captionBodyDark,
                      keyboardType: TextInputType.number,
                      onChanged: onChanged,
                      onFieldSubmitted: onFieldSubmitted,
                      focusNode: focus,
                      autofocus: autoFocus,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.icon,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: funcao,
                      icon: const Icon(FontAwesomeIcons.barcode,
                          color: AppColors.icon),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.01),
              child: Visibility(
                visible: isToggleVisible,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.04,
                      child: ToggleWidget(
                        value: valueCheckBox,
                        onChanged: onChangedCheckBox,
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'barcodeLeituraContinua'.tr,
                            style: AppTextStyles.bottomText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.005,
            ),
            Visibility(
              visible: isTextVisible,
              child: SizedBox(
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
                                '${infoLoteModel?.codigo} - ${infoLoteModel?.codPed ?? ''} ${infoLoteModel?.itinerario} - ${infoLoteModel?.veiculo}',
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
            ),
          ],
        ),
      ),
    );
  }
}
