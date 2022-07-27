import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upentregas/app/shared/constants/constant_dialog.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class DialogLocation extends StatelessWidget {
  const DialogLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 1,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 7,
              top: 20,
              right: 7,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Constants.padding),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'activateLocation'.tr,
                  style: GoogleFonts.sniglet(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton(
                        color: Colors.redAccent,
                        function: Get.back,
                        text: 'cancel'.tr),
                    const SizedBox(
                      width: 10,
                    ),
                    buildButton(
                        color: AppColors.defaultGreen,
                        function: ativar,
                        text: 'confirm'.tr),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> ativar() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openLocationSettings();
    Get.back();
  } else {
    await Geolocator.requestPermission();
    Get.back();
  }
}

ElevatedButton buildButton(
    {required Color color,
    required VoidCallback function,
    required String text}) {
  return ElevatedButton(
    onPressed: function,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      padding: const EdgeInsets.all(12.0),
      primary: color,
    ),
    child: Text(text, style: AppTextStyles.button),
  );
}
