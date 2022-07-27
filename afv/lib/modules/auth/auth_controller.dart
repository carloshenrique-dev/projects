import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/ui/loader/loader_mixin.dart';
import 'package:up_afv/application/themes/ui/login_master_bottom_sheet/login_master_bottom_sheet_mixin.dart';
import 'package:up_afv/application/themes/ui/messages/app_messages.dart';
import 'package:up_afv/application/themes/ui/messages/messages_mixin.dart';
import 'package:up_afv/core/models/auth/auth_model.dart';
import 'package:up_afv/core/services/api/api_provider.dart';
import 'package:up_afv/core/view_models/auth/auth_view_model.dart';

class AuthController extends GetxController
    with MessagesMixin, LoaderMixin, LoginMasterBottomSheetMixin {
  AuthModel model = AuthModel();
  final formKey = GlobalKey<FormState>();
  final visibilidade = true.obs;
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerSeller = TextEditingController();
  TextEditingController controllerIdMaster = TextEditingController();
  final loading = false.obs;
  final isFormValid = false.obs;
  final message = Rxn<MessageModel>();
  final loginMaster = Rxn<LoginMasterBottomSheetModel>();
  final AuthViewModel _authViewModel;

  ApiProvider apiProvider = ApiProvider(dio: Get.find());

  AuthController({required AuthViewModel authViewModel})
      : _authViewModel = authViewModel;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    loginMasterListener(loginMaster);
  }

  String? validateClientId(String? value) {
    if (value != null) {
      if (value.isEmpty || value.length < 8) {
        return AppMessages.errorIdClient;
      }
      return null;
    }
    return null;
  }

  String? validatePassword(String? value) =>
      value?.isEmpty ?? true ? 'fillPassword'.tr : null;

  String? validateSellerCode(String? value) =>
      value?.isEmpty ?? true ? 'fillSellerCode'.tr : null;

  void validateTextField(
      {String? clientId, String? password, int? sellerCode}) {
    model = model.copyWith(
      clientId: clientId,
      password: password,
      sellerCode: sellerCode,
    );
    log(model.toString());
  }

  void isSenhaVisivel() {
    if (visibilidade.value) {
      visibilidade.value = false;
    } else {
      visibilidade.value = true;
    }
  }

  Future<void> doAuth(BuildContext context) async {
    try {
      final form = formKey.currentState;
      if (form!.validate()) {
        loading(true);
        var authReturn = await _authViewModel.doAuth(authModel: model);
        if (authReturn.active == true && authReturn.idUp == false) {
          loading(false);
          Get.toNamed('/login');
        } else if (authReturn.active == true && authReturn.idUp == true) {
          loading(false);
          loginMaster(LoginMasterBottomSheetModel(
            onChanged: (value) => validateTextField(clientId: value),
            validator: validateClientId,
            controller: controllerIdMaster,
            context: context,
            onConfirm: () async => await authMaster(),
          ));
        } else {
          loading(false);
          message(MessageModel.error(message: AppMessages.errorAuth));
        }
      }
    } catch (e) {
      loading(false);
      log(e.toString());
      message(MessageModel.error(message: AppMessages.errorAuth));
    }
  }

  Future<void> authMaster() async {
    try {
      if (controllerIdMaster.text != '') {
        loading(true);
        var authReturn = await _authViewModel.doAuth(authModel: model);
        if (authReturn.active == true && authReturn.idUp == false) {
          loading(false);
          Get.toNamed('/login');
        } else {
          loading(false);
          message(MessageModel.error(message: 'idMasterError'.tr));
        }
      }
    } on Exception catch (e) {
      loading(false);
      log(e.toString());
      message(MessageModel.error(message: 'authError'.tr));
    }
  }

  isValidForm() {
    final formValid = formKey.currentState?.validate();
    if (formValid != null && formValid != isFormValid.value) {
      isFormValid.value = formValid;
    }
  }
}
