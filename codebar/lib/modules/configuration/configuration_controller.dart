import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/services/storage_services.dart';
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';

class ConfigurationController extends GetxController
    with LoaderMixin, MessagesMixin {
  TextEditingController timer = TextEditingController();
  final visualizaCodebar = false.obs;
  final visualAnimado = false.obs;
  final enableAmountControl = false.obs;
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final Storage _storage;

  ConfigurationController({
    required Storage storage,
  }) : _storage = storage;

  @override
  Future<void> onInit() async {
    super.onInit();
    await recoverStorage();
    loaderListener(loading);
    messageListener(message);
  }

  @override
  void onClose() {
    super.onClose();
    timer.clear();
  }

  Future<void> recoverStorage() async {
    try {
      Future.wait([
        readCodebarConfig(),
        readAmountConfig(),
        readAnimatedVisualConfig(),
        readTimeConfig(),
      ]);
    } catch (e) {
      message(MessageModel.error(message: 'errorReadConfigs'.tr));
    }
  }

  Future readCodebarConfig() async {
    var isVisible = await _storage.genericReadStorage(key: 'visualizaCodebar');
    if (isVisible != '') {
      visualizaCodebar.value = isVisible;
    } else {
      visualizaCodebar.value = false;
    }
  }

  Future readTimeConfig() async {
    var tempo = await _storage.genericReadStorage(key: 'tempo');
    if (tempo != '') {
      timer.text = tempo.toString();
    } else {
      tempo = '0';
    }
  }

  Future readAnimatedVisualConfig() async {
    var isAnimated = await _storage.genericReadStorage(key: 'visualAnimado');
    if (isAnimated != '') {
      visualAnimado.value = isAnimated;
    } else {
      visualAnimado.value = false;
    }
  }

  Future readAmountConfig() async {
    var amountControl =
        await _storage.genericReadStorage(key: 'enableAmountControl');
    if (amountControl != '') {
      enableAmountControl.value = amountControl;
    } else {
      enableAmountControl.value = false;
    }
  }

  alteraVisualizacaoCodebar(bool isVisible) {
    if (!isVisible) {
      visualizaCodebar.value = false;
    } else {
      visualizaCodebar.value = true;
    }
  }

  alteraVisualizacaoAnimacao(bool isVisible) {
    if (!isVisible) {
      visualAnimado.value = false;
    } else {
      visualAnimado.value = true;
    }
  }

  changeAmountControl(bool isVisible) {
    if (!isVisible) {
      enableAmountControl.value = false;
    } else {
      enableAmountControl.value = true;
    }
  }

  saveConfigs() async {
    try {
      loading(true);
      Future.wait([
        _storage.genericStorage(
            key: 'tempo', value: timer.text != '' ? timer.text : 0),
        _storage.genericStorage(
            key: 'visualizaCodebar', value: visualizaCodebar.value),
        _storage.genericStorage(
            key: 'visualAnimado', value: visualAnimado.value),
        _storage.genericStorage(
            key: 'enableAmountControl', value: enableAmountControl.value)
      ]);
      loading(false);
      message(MessageModel.sucess(message: 'successSaveConfigs'.tr));
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'errorSaveConfigs'.tr));
    }
  }
}
