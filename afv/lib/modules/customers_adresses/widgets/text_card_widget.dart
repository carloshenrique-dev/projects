import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/styles/app_text_styles.dart';

class TextCardWidget extends StatelessWidget {
  final String text;
  const TextCardWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.textFieldTitleDetailsWhite,
      maxLines: 7,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    );
  }
}
