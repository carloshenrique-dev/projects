import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/services/storage_services.dart';
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';

class ErroController extends GetxController with LoaderMixin, MessagesMixin {
  final visualAnimado = false.obs;
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final Storage _storage;

  ErroController({
    required Storage storage,
  }) : _storage = storage;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    readConfigs();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 1), () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  void readConfigs() async {
    try {
      var isVisible = await _storage.genericReadStorage(key: 'visualAnimado');
      if (isVisible != '') {
        visualAnimado.value = isVisible;
      } else {
        visualAnimado.value = false;
      }
    } catch (e) {
      message(MessageModel.error(message: 'errorReadConfigs'.tr));
    }
  }
}
