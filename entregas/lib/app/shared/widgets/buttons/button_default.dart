import 'package:flutter/material.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback function;

  const DefaultButton({Key? key, required this.function, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: const EdgeInsets.all(16.0),
        primary: Theme.of(context).primaryColor,
      ),
      child: Text(text, style: AppTextStyles.button),
    );
  }
}
