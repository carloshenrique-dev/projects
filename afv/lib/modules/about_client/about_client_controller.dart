import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AboutClientController extends GetxController {
  final currentPage = 0.obs;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  navigationBar(int value) {
    currentPage.value = value;
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
