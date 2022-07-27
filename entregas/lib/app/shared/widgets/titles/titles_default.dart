import 'package:flutter/material.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class TitleDefault extends StatelessWidget {
  final String? title;

  const TitleDefault({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Text(
      title!,
      style: theme.brightness == Brightness.dark
          ? AppTextStyles.title18
          : AppTextStyles.title18Black,
    );
  }
}
