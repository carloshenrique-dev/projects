import 'package:connectivity/connectivity.dart';

class SemConexaoController {
  Connectivity connectivity = Connectivity();

  Future<bool> checkConnectivity() async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
