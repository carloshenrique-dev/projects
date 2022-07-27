import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class TextFlipCardWidget extends StatelessWidget {
  final String text;
  final int maxLines;
  const TextFlipCardWidget({
    Key? key,
    required this.text,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      text,
      style: theme.brightness == Brightness.dark
          ? AppTextStyles.prodDetailsHeadWhite
          : AppTextStyles.prodDetailsHeadDark,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
