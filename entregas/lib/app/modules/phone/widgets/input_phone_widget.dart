import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class InputPhoneWidget extends StatelessWidget {
  final PhoneNumber number;
  final TextEditingController phoneController;
  final Function(PhoneNumber) funcao;
  const InputPhoneWidget({
    Key? key,
    required this.number,
    required this.phoneController,
    required this.funcao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: Get.width * 0.73,
        child: InternationalPhoneNumberInput(
          textStyle: theme.brightness == Brightness.dark
              ? AppTextStyles.title16
              : AppTextStyles.title16Black,
          spaceBetweenSelectorAndTextField: 0,
          inputDecoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            hintText: 'phonenumber'.tr,
            hintStyle: theme.brightness == Brightness.dark
                ? AppTextStyles.title16
                : AppTextStyles.title16Black,
          ),
          onInputChanged: funcao,
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          initialValue: number,
          textFieldController: phoneController,
          maxLength: 11,
          formatInput: false,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          inputBorder: const OutlineInputBorder(),
          onSaved: (PhoneNumber number) {
            //print('On Saved: $number');
          },
        ),
      ),
    );
  }
}
