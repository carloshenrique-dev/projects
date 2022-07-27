import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/id_model.dart';
import 'package:up_codebar/app/core/models/licencas_model.dart';
import 'package:up_codebar/app/core/services/crypto_services.dart';
import 'package:up_codebar/app/core/services/storage_services.dart';
import 'package:up_codebar/app/core/view_models/auth/auth_view_model.dart';
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';

class AuthController extends GetxController with LoaderMixin, MessagesMixin {
  final AuthViewModel _authViewModel;
  final Storage _storage;
  IDmodel model = IDmodel();
  Crypto crypto = Crypto();
  DeviceInfoPlugin device = DeviceInfoPlugin();
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final formKey = GlobalKey<FormState>();
  final visibilidade = true.obs;
  TextEditingController controllerID = TextEditingController();
  TextEditingController controllerSenhaID = TextEditingController();

  AuthController(
      {required AuthViewModel authViewModel, required Storage storage})
      : _authViewModel = authViewModel,
        _storage = storage;

  String? validateID(String? value) =>
      value?.isEmpty ?? true ? 'authId'.tr : null;

  String? validateSenhaID(String? value) =>
      value?.isEmpty ?? true ? 'loginSenha'.tr : null;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  void validateTextField({String? idCliente, String? senha}) {
    model = model.copyWithID(idCliente: idCliente, senha: senha);
  }

  Future<void> doAuth() async {
    try {
      final form = formKey.currentState;
      if (form!.validate()) {
        loading(true);
        AndroidDeviceInfo android = await device.androidInfo;
        String idCliente = await crypto.crypto(model.idCliente!, 'E', 'U');
        await _storage.gravaClientID(idCliente);
        List<LicencasModel> licenca = await _authViewModel.getLicencasCodebar();
        if (licenca.isNotEmpty) {
          var validacao = await validaLicenca(
              licenca: licenca,
              idCliente: idCliente,
              androidID: android.androidId!.toUpperCase());
          if (!validacao) {
            loading(false);
            message(MessageModel.error(message: 'liceUso'.tr));
          }
        } else {
          loading(false);
          message(MessageModel.error(message: 'semLice'.tr));
        }
      }
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'erroInfo'.tr));
    }
  }

  Future<bool> validaLicenca(
      {required List<LicencasModel> licenca,
      required String idCliente,
      required String androidID}) async {
    try {
      for (var i = 0; i < licenca.length; i++) {
        if (licenca[i].dispositivo == androidID) {
          loading(false);
          Get.toNamed('/login');
          return true;
        } else if (licenca[i].dispositivo == androidID &&
            licenca[i].situacao == 1) {
          return false;
        } else if (licenca[i].dispositivo == '' && licenca[i].situacao == 0) {
          var retorno = await _authViewModel.vinculaLicenca(
              sequencia: '${licenca[i].sequencia!}',
              dispositivo: androidID,
              senha: model.senha!);
          if (retorno.codRetorno == 1) {
            loading(false);
            Get.toNamed('/login');
            return true;
          }
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
