import 'package:flutter/material.dart';
import 'package:up_codebar/app/theme/styles/app_images.dart';

class LogoWidget extends StatelessWidget {
  final Color color;
  const LogoWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
      color: color,
      filterQuality: FilterQuality.high,
    );
  }
}
