import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_codebar/app/theme/styles/app_images.dart';

class SplashPage extends StatelessWidget{
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.background), fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                AppImages.splashImage,
                height: Get.height * 0.40,
                width: Get.width * 0.40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}