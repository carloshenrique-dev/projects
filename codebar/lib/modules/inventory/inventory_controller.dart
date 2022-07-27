import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/services/barcode_services.dart';
import 'package:up_codebar/app/core/services/storage_services.dart';
import 'package:up_codebar/app/core/view_models/inventory/inventory_view_model.dart';
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';

class InventoryController extends GetxController
    with LoaderMixin, MessagesMixin, BarcodeServices {
  final InventoryViewModel _inventoryViewModel;
  final Storage _storage;
  final message = Rxn<MessageModel>();
  TextEditingController inputBarCode = TextEditingController();
  final loading = false.obs;
  final hasText = false.obs;
  final valueCheckBox = false.obs;
  var codebar = '';
  var map = {};
  final isListVisible = false.obs;
  var inventoryList = [].obs;
  FocusNode focus = FocusNode();

  InventoryController({
    required InventoryViewModel inventoryViewModel,
    required Storage storage,
  })  : _inventoryViewModel = inventoryViewModel,
        _storage = storage;

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

  manualConference() async {
    loading(true);
    try {
      if (codebar != '' && codebar.length == 38) {
        map = validaBarCode(codebar);
        var retorno = await _inventoryViewModel.setItemInventario(
          codProd: int.tryParse(map['codProd'])!,
          codEtiqueta: map['barcode'],
          qtd: double.parse(map['qtd']),
          usuario: await _storage.retornaUser(),
        );
        if (retorno.codRetorno == 1) {
          inventoryList.insert(0, map);
          isListVisible.value = true;
          loading(false);
        } else {
          loading(false);
          Get.toNamed('/erro', arguments: retorno.msgRetorno);
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

  scanBarCode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancelar'.tr, true, ScanMode.BARCODE);

      if (barcodeScanRes == '-1') {
        message(MessageModel.error(message: 'barcodeLeitura'.tr));
      } else {
        loading(true);
        codebar = barcodeScanRes;
        if (codebar.length == 38) {
          map = validaBarCode(codebar);
          var retorno = await _inventoryViewModel.setItemInventario(
            codProd: int.tryParse(map['codProd'])!,
            codEtiqueta: map['barcode'],
            qtd: double.parse(map['qtd']),
            usuario: await _storage.retornaUser(),
          );
          if (retorno.codRetorno == 1) {
            inventoryList.insert(0, map);
            isListVisible.value = true;
            loading(false);
          } else {
            loading(false);
            Get.toNamed('/erro', arguments: retorno.msgRetorno);
          }
        } else {
          loading(false);
          message(MessageModel.error(message: 'barcodeFormatoIncorreto'.tr));
          inputBarCode.clear();
        }
      }
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'barcodeErroLeitura'.tr));
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
    codebar = inputBarCode.text;
    manualConference();
  }

  onFieldSubmitted({
    String? value,
    required TextEditingController inputBarCode,
  }) {
    if (value != '' && value != null) {
      codebar = inputBarCode.text;
      manualConference();
    }
  }
}
