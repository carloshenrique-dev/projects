import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

class ConnectionService extends GetxController {
  //Instance of Flutter Connectivity
  final Connectivity _connectivity;

  ConnectionService({
    required Connectivity connectivity,
  }) : _connectivity = connectivity;

  @override
  Future<void> onInit() async {
    super.onInit();
    await checkConnectivity();
    streamConexao();
  }

  void streamConexao() {
    _connectivity.onConnectivityChanged.listen((conexao) async {
      if (conexao == ConnectivityResult.none) {
        Get.toNamed('/connection');
      } else {
        Get.back();
      }
    });
  }

  Future<bool> checkConnectivity() async {
    try {
      var conexao = await _connectivity.checkConnectivity();
      if (conexao == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
