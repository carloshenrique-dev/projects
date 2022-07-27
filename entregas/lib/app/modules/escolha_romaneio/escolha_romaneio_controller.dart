import 'package:get/get.dart';
import 'package:upentregas/app/modules/romaneio/romaneio_view.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/shared/ui/loader/loader_mixin.dart';
import 'package:upentregas/app/shared/ui/messages/messages_mixin.dart';

class EscolhaRomaneioController extends GetxController
    with LoaderMixin, MessagesMixin {
  final listaRomaneios = [].obs;
  final nomeFantasia = ''.obs;
  final listHeightSize = 0.1.obs;
  final selectedIndex = 9999.obs;
  final loading = false.obs;
  final message = Rxn<MessageModel>();

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    retornaInfos();
    listHeight();
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;
    String greeting = '';

    if (timeNow <= 12) {
      greeting = 'morning'.tr;
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      greeting = 'afternoon'.tr;
    } else if ((timeNow > 16) && (timeNow < 20)) {
      greeting = 'evening'.tr;
    } else {
      greeting = 'night'.tr;
    }
    return greeting;
  }

  listHeight() {
    if (listaRomaneios.length == 1) {
      listHeightSize.value = 0.1;
    } else if (listaRomaneios.length == 2) {
      listHeightSize.value = 0.2;
    } else if (listaRomaneios.length == 3) {
      listHeightSize.value = 0.3;
    } else if (listaRomaneios.length >= 4) {
      listHeightSize.value = 0.39;
    } else {
      listHeightSize.value = 0.1;
    }
  }

  retornaInfos() {
    nomeFantasia.value = Get.parameters['nomeFantasia'] ?? 'UpSoftware';
    listaRomaneios.value = Get.arguments;
  }

  validarDados() {
    if (selectedIndex.value == 9999) {
      message(MessageModel.error(message: 'chooseRomaneio'.tr));
    } else {
      idGeral = selectedIndex.value;
      Get.offAll(() => RomaneioView(
            id: selectedIndex.value,
            nomeFantasia: nomeFantasia.value,
          ));
    }
  }
}
