import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/modules/paradas/parada_view.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class CardParada extends StatefulWidget {
  final int id;
  final bool emParada;
  final String? descParada;

  const CardParada({
    Key? key,
    required this.id,
    required this.emParada,
    required this.descParada,
  }) : super(key: key);

  @override
  _CardParadaState createState() => _CardParadaState();
}

class _CardParadaState extends State<CardParada>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double scale = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    _animationController.addStatusListener((status) {});
    _animationController.addListener(() {
      setState(() {
        scale = _animationController.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2b9cd1),
      elevation: 10.0,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: Get.height * 0.01),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: scale,
                  child: const Icon(
                    Icons.stop_sharp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            title: Text(
              '${widget.descParada}',
              style: AppTextStyles.title20,
            ),
            onTap: () {
              Get.to(() => ParadaView(
                    emParada: widget.emParada,
                    docId: widget.id,
                  ));
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
