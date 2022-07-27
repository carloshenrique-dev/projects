import 'package:flutter/material.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';

class ToggleWidget extends StatelessWidget {
  final bool value;
  final Function(bool?)? onChanged;
  const ToggleWidget({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: value,
      onChanged: onChanged,
      inactiveThumbColor: AppColors.whiteColor,
      inactiveTrackColor: AppColors.redCard,
      activeTrackColor: AppColors.greenCard,
      activeColor: AppColors.whiteColor,
    );
  }
}
