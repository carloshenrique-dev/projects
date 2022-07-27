import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/licencas_model.dart';
import 'package:up_codebar/app/core/models/user_model.dart';
import 'package:up_codebar/app/core/services/crypto_services.dart';
import 'package:up_codebar/app/core/services/storage_services.dart';
import 'package:up_codebar/app/core/view_models/auth/auth_view_model.dart';
import 'package:up_codebar/app/core/view_models/login/login_view_model.dart';
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  final LoginViewModel _loginViewModel;
  final Storage _storage;
  final AuthViewModel _authViewModel;
  UserModel model = UserModel();
  Crypto crypto = Crypto();
  DeviceInfoPlugin device = DeviceInfoPlugin();
  final loading = false.obs;
  final visibilidade = true.obs;
  final message = Rxn<MessageModel>();
  final formKey = GlobalKey<FormState>();
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  LoginController({
    required LoginViewModel loginViewModel,
    required Storage storage,
    required AuthViewModel authViewModel,
  })  : _loginViewModel = loginViewModel,
        _storage = storage,
        _authViewModel = authViewModel;

  String? validateUsuario(String? value) =>
      value?.isEmpty ?? true ? 'loginUsuario'.tr : null;

  String? validateSenha(String? value) =>
      value?.isEmpty ?? true ? 'loginSenha'.tr : null;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  Future<void> doLogin() async {
    String idCliente;
    final form = formKey.currentState;
    if (form!.validate()) {
      loading(true);
      AndroidDeviceInfo android = await device.androidInfo;
      var id = await _storage.recuperaClientID();
      if (id != '') {
        idCliente = await crypto.crypto(id, 'E', 'U');
        List<LicencasModel> licenca = await _authViewModel.getLicencasCodebar();
        if (licenca.isNotEmpty) {
          var validacao = await validaLicenca(
              licenca: licenca,
              idCliente: idCliente,
              androidID: android.androidId!.toUpperCase());
          if (!validacao) {
            Get.offAllNamed('/auth');
            message(MessageModel.error(message: 'naoRegistro'.tr));
          } else {
            final retornoLogin = await _loginViewModel.doLogin(
                usuario: model.usuario!, senha: model.senha!);
            if (retornoLogin.codRetorno == 0) {
              loading(false);
              message(MessageModel.error(message: 'loginInvalido'.tr));
            } else if (retornoLogin.codRetorno == 1) {
              loading(false);
              _storage.expireDate();
              _storage.salvaDados(login: model.usuario!, senha: model.senha!);
              Get.offAllNamed('/home');
            } else {
              loading(false);
              message(MessageModel.error(message: 'loginErro'.tr));
            }
          }
        } else {
          loading(false);
          message(MessageModel.error(message: 'semLice'.tr));
        }
      } else {
        Get.offAllNamed('/auth');
      }

      try {} catch (e) {
        loading(false);
        message(MessageModel.error(message: 'serverError'.tr));
      }
    }
  }

  void validateTextField({String? usuario, String? senha}) {
    model = model.copyWith(usuario: usuario, senha: senha);
  }

  Future<bool> validaLicenca(
      {required List<LicencasModel> licenca,
      required String idCliente,
      required String androidID}) async {
    try {
      for (var i = 0; i < licenca.length; i++) {
        if (licenca[i].dispositivo == androidID) {
          loading(false);
          return true;
        }
      }
      return false;
    } on Exception {
      return false;
    }
  }

  void isSenhaVisivel() {
    if (visibilidade.value) {
      visibilidade.value = false;
    } else {
      visibilidade.value = true;
    }
  }
}
