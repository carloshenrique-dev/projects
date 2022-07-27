import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_signature/signature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/shared/ui/messages/message_provisorio.dart';

HandSignatureControl control = HandSignatureControl(
  threshold: 3.0,
  smoothRatio: 0.65,
  velocityRange: 0.2,
);

ValueNotifier<ByteData?> rawImage = ValueNotifier<ByteData?>(null);

class SignatureView extends StatelessWidget {
  const SignatureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          Get.back();
          return true;
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF404040),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    buildScreen(context),
                    buildButtons(context),
                    buildSwapOrientation(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildScreen(BuildContext context) {
    control.clear();
    return Expanded(
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(),
              color: Colors.white,
              child: HandSignaturePainterView(
                color: Colors.black,
                control: control,
                type: SignatureDrawType.shape,
              ),
            ),
            CustomPaint(
              painter: DebugSignaturePainterCP(
                color: Colors.black,
                control: control,
                cp: false,
                cpStart: false,
                cpEnd: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSwapOrientation(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final newOrientation =
            isPortrait ? Orientation.landscape : Orientation.portrait;

        control.clear();
        setOrientation(newOrientation);
      },
      child: Container(
        color: const Color(0xFF303030),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPortrait
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_landscape,
              size: 40,
            ),
            const SizedBox(width: 12),
            Text(
              'changeOrientation'.tr,
              style: GoogleFonts.sniglet(
                fontStyle: FontStyle.normal,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  Widget buildButtons(BuildContext context) => Container(
        color: const Color(0xFF404040),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildCheck(context),
            buildClear(),
          ],
        ),
      );

  Widget buildCheck(BuildContext context) => IconButton(
        iconSize: 36,
        icon: const Icon(Icons.check, color: Colors.green),
        onPressed: () async {
          try {
            rawImage.value = await control.toImage(
                color: Colors.black, size: 3, width: 500, height: 500);
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);

            Get.back();
          } catch (e) {
            MessageProvisorio().showMessage(message: 'subscriptionRequired'.tr);
            //print(e);
          }
        },
      );

  Widget buildClear() => IconButton(
        iconSize: 36,
        icon: const Icon(Icons.edit, color: Colors.red),
        onPressed: () => control.clear(),
      );
}
