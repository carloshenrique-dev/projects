import 'package:flutter/material.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class TextFieldNumber extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;

  const TextFieldNumber({Key? key, this.hintText, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 60),
          child: TextField(
            textAlign: TextAlign.center,
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 8,
            style: theme.brightness == Brightness.dark
                ? AppTextStyles.title16
                : AppTextStyles.title16Black,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              hintText: hintText,
              hintStyle: theme.brightness == Brightness.dark
                  ? AppTextStyles.title16
                  : AppTextStyles.title16Black,
            ),
          ),
        ),
      ],
    );
  }
}
