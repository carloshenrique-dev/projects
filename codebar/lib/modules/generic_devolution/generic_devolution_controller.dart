import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/services/barcode_services.dart';
import 'package:up_codebar/app/core/view_models/devolution/devolution_view_model.dart';
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';

class GenericDevolutionController extends GetxController
    with LoaderMixin, MessagesMixin, BarcodeServices {
  final DevolutionViewModel _devolutionViewModel;
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  TextEditingController inputBarCode = TextEditingController();
  var codeBar = '';
  var tipo = '';
  var map = {};
  var isCardVisible = false.obs;
  var valueCheckBox = false.obs;
  var hasText = false.obs;
  var devolutionList = [].obs;
  FocusNode focus = FocusNode();

  GenericDevolutionController({
    required DevolutionViewModel devolutionViewModel,
  }) : _devolutionViewModel = devolutionViewModel;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    focus.addListener(onFocusChange);
    focus.requestFocus();
  }

  @override
  void onClose() {
    super.onClose();
    inputBarCode.clear();
    focus.removeListener(() {
      onFocusChange;
    });
    focus.dispose();
  }

  onFocusChange() {
    if (!focus.hasFocus && Get.isBottomSheetOpen == false) {
      focus.requestFocus();
    }
  }

  Future<void> manualConference() async {
    loading(true);
    try {
      if (codeBar != '' && codeBar.length == 38) {
        var isOk = await setItemDevol();
        if (isOk.codRetorno == 1) {
          map = validaBarCode(codeBar);
          devolutionList.insert(0, map);
          isCardVisible.value = true;
          loading(false);
        } else {
          loading(false);
          Get.toNamed('/erro', arguments: isOk.msgRetorno);
        }
      } else {
        loading(false);
        message(MessageModel.error(message: 'barcodeFormatoIncorreto'.tr));
        inputBarCode.clear();
      }
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'barcodeLeituraManual'.tr));
    }
  }

  Future<void> scanBarCode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancelar'.tr, true, ScanMode.BARCODE);

      if (barcodeScanRes == '-1') {
        message(MessageModel.error(message: 'barcodeLeitura'.tr));
      } else if (barcodeScanRes.length == 38) {
        loading(true);
        codeBar = barcodeScanRes;
        update();
        var isOk = await setItemDevol();
        if (isOk.codRetorno == 1) {
          map = validaBarCode(codeBar);
          devolutionList.insert(0, map);
          isCardVisible.value = true;
          loading(false);
        } else {
          loading(false);
          Get.toNamed('/erro', arguments: isOk.msgRetorno);
        }
      } else {
        loading(false);
        message(MessageModel.error(message: 'barcodeFormatoIncorreto'.tr));
        inputBarCode.clear();
      }
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'barcodeErroLeitura'.tr));
    }
  }

  Future<DefaultReturnModel> setItemDevol() async {
    try {
      if (codeBar != '' && tipo != '') {
        var retorno = await _devolutionViewModel.setItemDevol(
            codEtiqueta: codeBar, tipo: tipo);
        return DefaultReturnModel(
            msgRetorno: retorno.msgRetorno, codRetorno: retorno.codRetorno);
      }
      inputBarCode.clear();
      return DefaultReturnModel(
          msgRetorno: 'barcodeErroLeitura'.tr, codRetorno: 0);
    } catch (e) {
      return DefaultReturnModel(
          msgRetorno: 'barcodeErroGravacao'.tr, codRetorno: 0);
    }
  }

  onChanged(String? value) {
    if (value != '' && value != null) {
      hasText.value = true;
    } else {
      hasText.value = false;
    }
  }

  onChangedCheckBox(bool? value) {
    if (!valueCheckBox.value) {
      valueCheckBox.value = true;
    } else {
      valueCheckBox.value = false;
    }
  }

  conferenceFunction(TextEditingController inputBarCode) {
    codeBar = inputBarCode.text;
    manualConference();
  }

  onFieldSubmitted(
      {String? value, required TextEditingController inputBarCode}) {
    if (value != '' && value != null) {
      codeBar = inputBarCode.text;
      manualConference();
    }
  }

  String returnTitle() {
    if (tipo == 'T') {
      return 'devolutionPageCard1'.tr;
    } else if (tipo == 'S') {
      return 'devolutionPageCard2'.tr;
    } else if (tipo == 'N') {
      return 'devolutionPageCard3'.tr;
    } else {
      return 'genericDevolutionPageTitle'.tr;
    }
  }
}
