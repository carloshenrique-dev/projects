import 'dart:developer';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/ui/change_device_dialog/change_device_dialog_mixin.dart';
import 'package:up_afv/application/themes/ui/loader/loader_mixin.dart';
import 'package:up_afv/application/themes/ui/messages/messages_mixin.dart';
import 'package:up_afv/core/models/login/login_model.dart';
import 'package:up_afv/core/models/configs/preferences_model.dart';
import 'package:up_afv/core/view_models/login/login_view_model.dart';

class LoginController extends GetxController
    with MessagesMixin, LoaderMixin, ChangeDeviceDialogMixin {
  LoginModel model = LoginModel();
  final formKey = GlobalKey<FormState>();
  final visibilidade = true.obs;
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  final preferences = <PreferencesModel>[].obs;
  final isFormValid = false.obs;
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final changeDevice = Rxn<ChangeDeviceModel>();
  final LoginViewModel _loginViewModel;
  final DeviceInfoPlugin _device = DeviceInfoPlugin();

  LoginController({
    required LoginViewModel loginViewModel,
  }) : _loginViewModel = loginViewModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    dialogListener(changeDevice);
    await getInfos();
  }

  String? validateUser(String? value) =>
      value?.isEmpty ?? true ? 'fillUser'.tr : null;

  String? validatePassword(String? value) =>
      value?.isEmpty ?? true ? 'fillPassword'.tr : null;

  Future<void> getInfos() async {
    try {
      var ret = await _loginViewModel.getPreferences();
      preferences.addAll(ret);
    } catch (e) {
      log(e.toString());
      message(MessageModel.error(message: 'errorRecoverInfo'.tr));
    }
  }

  void validateTextField({String? user, String? password}) {
    model = model.copyWith(user: user, password: password);
  }

  void isSenhaVisivel() {
    if (visibilidade.value) {
      visibilidade.value = false;
    } else {
      visibilidade.value = true;
    }
  }

  Future<void> doLogout() async {
    try {
      loading(true);
      if (preferences[0].sellerCode != null && preferences[0].sellerCode != 0) {
        if (await _loginViewModel.doLogout()) {
          loading(false);
          Get.offAllNamed('/auth');
        } else {
          loading(false);
          message(MessageModel.error(message: 'errorLogout'.tr));
        }
      }
    } catch (e) {
      loading(false);
      log(e.toString());
      message(MessageModel.error(message: 'errorLogout'.tr));
    }
  }

  Future<void> doLogin() async {
    try {
      final form = formKey.currentState;
      if (form!.validate()) {
        loading(true);
        AndroidDeviceInfo device = await _device.androidInfo;
        var ret = await _loginViewModel.doLogin(loginModel: model);
        if (preferences[0].sellerCode == ret.codVend) {
          if (ret.situacao == 'A' && ret.dispositivo == device.id) {
            loading(false);
            Get.offAllNamed('/home');
          } else if (ret.situacao == 'A' && ret.dispositivo == null) {
            var value = await _loginViewModel.setDevice(
                deviceId: device.id ?? '', sellerCode: ret.codVend!);
            if (value) {
              loading(false);
              Get.offAllNamed('/home');
            }
          } else if (ret.situacao == 'A' && ret.dispositivo != device.id) {
            loading(false);
            changeDevice(
              ChangeDeviceModel(
                onConfirm: () async {
                  loading(true);
                  var value = await _loginViewModel.setDevice(
                      deviceId: device.id ?? '', sellerCode: ret.codVend!);
                  if (value) {
                    loading(false);
                    Get.offAllNamed('/home');
                  } else {
                    loading(false);
                    message(
                        MessageModel.error(message: 'errorUpdateDevice'.tr));
                  }
                },
                onCancel: () => Get.offAllNamed('/auth'),
              ),
            );
          } else {
            loading(false);
            message(MessageModel.error(message: 'inactiveLicense'.tr));
          }
        } else {
          loading(false);
          message(MessageModel.error(message: 'errorCodCli'.tr));
        }
      }
    } catch (e) {
      loading(false);
      log(e.toString());
      message(MessageModel.error(message: 'errorUserPassword'.tr));
    }
  }

  isValidForm() {
    final formValid = formKey.currentState?.validate();
    if (formValid != null && formValid != isFormValid.value) {
      isFormValid.value = formValid;
    }
  }
}
