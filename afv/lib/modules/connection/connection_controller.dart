import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController {
  final Connectivity _connectivity;

  ConnectionController({
    required Connectivity connectivity,
  }) : _connectivity = connectivity;

  Future<void> checkConnectivity() async {
    var hasConnection = await _connectivity.checkConnectivity();

    if (hasConnection == ConnectivityResult.none) {
      Get.snackbar('error'.tr, 'connection'.tr);
    } else {
      Get.back();
    }
  }
}
