import 'package:flutter/material.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';

class IndicatorApp extends StatelessWidget {
  const IndicatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.defaultGreen,
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
