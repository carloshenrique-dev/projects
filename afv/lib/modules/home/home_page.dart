import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:up_afv/application/themes/widgets/sidebar_menu_widget.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: const SafeArea(child: SidebarMenuWidget()),
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
                onPressed: () => controller.insertProduct(),
                child: const Text('Prod order')),
            Center(
              child: FloatingActionButton(
                onPressed: () =>
                    controller.scaffoldKey.currentState!.openDrawer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
