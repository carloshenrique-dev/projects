import 'package:flutter/material.dart';

import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback funcao;
  final String text;
  final Color color;
  const ElevatedButtonWidget({
    Key? key,
    required this.funcao,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: funcao,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: const EdgeInsets.all(16.0),
        primary: color,
      ),
      child: Text(
        text,
        style: AppTextStyles.button,
      ),
    );
  }
}
