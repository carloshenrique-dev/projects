import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:up_afv/core/models/login/login_model.dart';
import 'package:up_afv/core/services/connection/connection_service.dart';
import 'package:up_afv/core/services/db/db_service.dart';
import 'package:up_afv/core/view_models/login/login_view_model.dart';

class AuthService extends GetxService {
  final DbService _dbService;
  final LoginViewModel _loginViewModel;
  final ConnectionService _connectionService;
  Timer? _timer;

  AuthService({
    required DbService dbService,
    required LoginViewModel loginViewModel,
    required ConnectionService connectionService,
  })  : _dbService = dbService,
        _loginViewModel = loginViewModel,
        _connectionService = connectionService;

  @override
  Future<void> onInit() async {
    super.onInit();
    //await authListener();
  }

  @override
  onClose() {
    super.onClose();
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  Future<void> authListener() async {
    try {
      Timer.periodic(const Duration(minutes: 5), (timer) async {
        log('auth service started');
        if (await _connectionService.checkConnectivity()) {
          var retorno = await _dbService.queryPreferences();
          log('auth service excecuted');
          if (retorno.isNotEmpty &&
              Get.currentRoute != '/login' &&
              Get.currentRoute != '/auth') {
            var login = await _loginViewModel.doLogin(
                loginModel: LoginModel(
                    user: retorno[0].user, password: retorno[0].password));
            if (login.situacao == 'I' || login.situacao == null) {
              Get.offAllNamed('/auth');
              timer.cancel();
            }
          }
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
