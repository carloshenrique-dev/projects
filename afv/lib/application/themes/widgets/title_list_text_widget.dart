import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class TitleListTextWidget extends StatelessWidget {
  final String text;
  const TitleListTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Text(
      text,
      style: theme.brightness == Brightness.dark
          ? AppTextStyles.homeTitleWhite
          : AppTextStyles.homeTitleDark,
      textAlign: TextAlign.start,
    );
  }
}
