import 'package:flutter/material.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class ButtonParadaWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  const ButtonParadaWidget(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: const EdgeInsets.all(16.0),
        primary: color,
      ),
      child: Text(
        title,
        style: AppTextStyles.button,
      ),
    );
  }
}
