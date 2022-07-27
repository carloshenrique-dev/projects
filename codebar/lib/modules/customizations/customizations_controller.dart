import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/barcode_scanner_model.dart';
import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/info_lote_model.dart';
import 'package:up_codebar/app/core/models/itens_pedido_model.dart';
import 'package:up_codebar/app/core/services/barcode_services.dart';
import 'package:up_codebar/app/core/services/storage_services.dart';
import 'package:up_codebar/app/core/view_models/barcode/barcode_view_model.dart';
import 'package:up_codebar/app/core/view_models/pedido/pedido_view_model.dart';
import 'package:up_codebar/app/ui/bottom_sheet/bottom_sheet_mixin.dart';
import 'package:up_codebar/app/ui/dialog_customization/dialog_customization_mixin.dart';
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';
import 'package:up_codebar/modules/itens_pedido/itens_pedido_controller.dart';

class CustomizationsController extends GetxController
    with
        LoaderMixin,
        MessagesMixin,
        BarcodeServices,
        BottomSheetMixin,
        DialogCustomizationMixin {
  var itemPedido = Rxn<ItensPedidoModel>();
  var infoLoteModel = Rxn<InfoLoteModel>();
  FocusNode focus = FocusNode();
  FocusNode qtdFocus = FocusNode();
  TextEditingController inputBarCode = TextEditingController();
  TextEditingController dialogController = TextEditingController();
  final bottomSheet = Rxn<BottomSheetModel>();
  final dialog = Rxn<DialogCustomizationModel>();
  final message = Rxn<MessageModel>();
  final loading = false.obs;
  final hasText = false.obs;
  final hasTextQtd = false.obs;
  final pe = false.obs;
  final qtd = 1.0.obs;
  final selectedValue = Rxn<String>().obs;
  var codebar = '';
  final valueCheckBox = false.obs;
  final BarcodeViewModel _barcodeViewModel;
  final PedidoViewModel _pedidoViewModel;
  final ItensPedidoController _itensPedidoController;
  final Storage _storage;

  CustomizationsController({
    required BarcodeViewModel barcodeViewModel,
    required Storage storage,
    required PedidoViewModel pedidoViewModel,
    required ItensPedidoController itensPedidoController,
  })  : _barcodeViewModel = barcodeViewModel,
        _storage = storage,
        _pedidoViewModel = pedidoViewModel,
        _itensPedidoController = itensPedidoController;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    bottomSheetListener(bottomSheet);
    dialogCustomizationListener(dialog);
    focus.addListener(onFocusChange);
    qtdFocus.addListener(onFocusQtdChange);
    focus.requestFocus();
    itemPedido(Get.arguments[0]);
    infoLoteModel(Get.arguments[1]);
  }

  Future<bool> getItensPedido() async {
    _itensPedidoController.comeBackPage();
    return await _itensPedidoController.getItensPedido();
  }

  Future<bool> popScope() async {
    focus.addListener(onFocusChange);
    focus.requestFocus();
    return true;
  }

  Future<void> limpaItem({required ItensPedidoModel pedidoModel}) async {
    if (pedidoModel.qtdConfFat != 0 && pedidoModel.item != null) {
      bottomSheet(
        BottomSheetModel(
          onConfirm: () async {
            loading(true);
            try {
              var retorno = await deleteItemIndivLote(pedidoModel: pedidoModel);
              if (retorno.codRetorno == 0) {
                loading(false);
                message(MessageModel.error(message: 'barcodeErroLimpeza'.tr));
              } else if (retorno.codRetorno == 1) {
                await getItensPedidoIndex();
                loading(false);
                Get.back(closeOverlays: true);
                clear();
                await getItensPedido();
                message(
                    MessageModel.sucess(message: 'barcodeSucessoLimpeza'.tr));
              } else {
                loading(false);
                message(MessageModel.error(message: 'barcodeErroLimpeza'.tr));
              }
            } catch (e) {
              loading(false);
              message(MessageModel.error(message: 'barcodeErroLimpeza'.tr));
            }
          },
        ),
      );
    } else {
      loading(false);
      message(MessageModel.error(message: 'barcodeLimpezaQtd'.tr));
    }
  }

  //reordena o index pos o item ser conferido
  Future<void> getItensPedidoIndex() async {
    try {
      loading(true);
      final lista = await _pedidoViewModel.getItensPedido(
          codPed: infoLoteModel.value!.codPed!);
      itemPedido(lista.firstWhere((element) =>
          element.codProd == itemPedido.value!.codProd &&
          element.item == itemPedido.value!.item));
      loading(false);
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'itensPedidoGetItens'.tr));
    }
  }

  //limpa a conferencia dos itens
  Future<DefaultReturnModel> deleteItemIndivLote(
      {required ItensPedidoModel pedidoModel}) async {
    try {
      loading(true);
      final retornoDelete = await _pedidoViewModel.deleteItemIndivPedido(
        codPed: infoLoteModel.value!.codPed!,
        item: pedidoModel.item!,
      );
      loading(false);
      return DefaultReturnModel(
          msgRetorno: retornoDelete.msgRetorno,
          codRetorno: retornoDelete.codRetorno);
    } catch (e) {
      loading(false);
      return DefaultReturnModel(codRetorno: 0, msgRetorno: 'serverError'.tr);
    }
  }

  onFocusChange() {
    if (!focus.hasFocus && Get.isBottomSheetOpen == false) {
      focus.requestFocus();
    }
  }

  onFocusQtdChange() {
    if (!qtdFocus.hasFocus && Get.isBottomSheetOpen == false) {
      qtdFocus.requestFocus();
    }
  }

  conferenceFunction(TextEditingController inputBarCode) {
    codebar = inputBarCode.text;
    manualConference();
  }

  //realiza conferencia manual chamando dialogo de qtd
  Future<void> manualConference() async {
    try {
      if (codebar != '') {
        update();
        bool? retorno = await isPedido();
        if (retorno != null && retorno == false) {
          message(MessageModel.error(message: 'barcodeCodigoNaoEncontrado'.tr));
          inputBarCode.clear();
        }
      }
    } catch (e) {
      message(MessageModel.error(message: 'barcodeLeituraManual'.tr));
    }
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

  //eventos da barra de codigo de barras
  onChanged(String? value) {
    if (value != '' && value != null) {
      hasText.value = true;
    } else {
      hasText.value = false;
    }
  }

  onChangedQtd(String? value) {
    if (value != '' && value != null) {
      hasTextQtd.value = true;
    } else {
      hasTextQtd.value = false;
    }
  }

  onChangedCheckBox(bool? value) {
    if (!valueCheckBox.value) {
      valueCheckBox.value = true;
    } else {
      valueCheckBox.value = false;
    }
  }

  Future<void> scanBarcode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancelar'.tr, true, ScanMode.BARCODE);

      if (barcodeScanRes == '-1') {
        message(MessageModel.error(message: 'barcodeLeitura'.tr));
      } else {
        codebar = barcodeScanRes;
        update();
        bool? retorno = await isPedido();
        if (retorno != null && retorno == false) {
          message(MessageModel.error(message: 'barcodeCodigoNaoEncontrado'.tr));
          inputBarCode.clear();
        }
      }
    } catch (e) {
      message(MessageModel.error(message: 'barcodeErroLeitura'.tr));
    }
  }

  isPedido() async {
    String? etiqueta = codebar;
    double quantidade = 1;

    if (codebar.length == 38) {
      message(MessageModel.error(message: 'barcodeErroLeitura'.tr));
    } else {
      if (valueCheckBox.value == false && codebar.length != 38) {
        pe.value = false;
        await carregaComboFator(
          itemPedido: itemPedido.value!,
          etiqueta: etiqueta,
        );
      }
      //quando o valor foi digitado ou lido e a leitura continua esta ativa
      else if (hasText.value == true && valueCheckBox.value == true) {
        var retorno = await setItensPedido(
            itemPedido: itemPedido.value!, qtd: quantidade, etiqueta: etiqueta);
        if (retorno.codRetorno == 0) {
          inputBarCode.clear();
          Get.toNamed('/erro', arguments: retorno.msgRetorno);
        } else {
          await getItensPedidoIndex();
          Get.back(closeOverlays: true);
          clear();
          await getItensPedido();
        }
      }
      //leitura direta caso as condicoes nao sejam atendidas
      else {
        var retorno = await setItensPedido(
            itemPedido: itemPedido.value!, qtd: quantidade, etiqueta: etiqueta);
        if (retorno.codRetorno == 0) {
          inputBarCode.clear();
          Get.toNamed('/erro', arguments: retorno.msgRetorno);
        } else {
          await getItensPedidoIndex();
          Get.back(closeOverlays: true);
          clear();
          await getItensPedido();
        }
      }
    }
  }

  clear() {
    focus.removeListener(onFocusChange);
    inputBarCode.clear();
    focus.unfocus();
  }

  Future<void> carregaComboFator(
      {required ItensPedidoModel itemPedido, required String etiqueta}) async {
    /*String isPeText = '';
    if (pe.value) {
      isPeText =
          '${'qtdLida'.tr} ${itemPedido.peUnid} = ${itemPedido.peQtd} ${itemPedido.unid}.\n${'insiraQtd'.tr} ${itemPedido.peUnid}';
    } else {
      isPeText =
          '${'qtdLida'.tr} ${itemPedido.fatorUn} = ${itemPedido.fator} ${itemPedido.unid}.\n${'insiraQtd'.tr} ${itemPedido.fatorUn}';
    }

    if (itemPedido.peQtd == 0 && pe.value == true) {
      isPeText = 'insiraQtd'.tr;
    }
    if (itemPedido.fator == 0 && pe.value == false) {
      isPeText = 'insiraQtd'.tr;
    }*/
    //clear();
    qtdFocus.requestFocus();
    dialog(
      DialogCustomizationModel(
        scope: () => popScope(),
        onCancel: () => popScope(),
        hasText: hasTextQtd.value,
        onChanged: (value) => onChangedQtd(value),
        onFieldSubmitted: (value) async {
          loading(true);
          try {
            var retorno = await setItensPedido(
                itemPedido: itemPedido,
                qtd: double.parse(dialogController.text),
                etiqueta: etiqueta);
            if (retorno.codRetorno == 0) {
              loading(false);
              dialogController.clear();
              Get.back();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              await getItensPedidoIndex();
              Get.back(closeOverlays: true);
              clear();
              await getItensPedido();
            }
            qtd.value = 1;
          } catch (e) {
            qtd.value = 1;
            inputBarCode.clear();
            message(MessageModel.error(message: 'barcodeErroConferencia'.tr));
          }
        },
        focus: qtdFocus,
        textController: dialogController,
        onConfirm: () async {
          loading(true);
          try {
            var retorno = await setItensPedido(
                itemPedido: itemPedido,
                qtd: double.parse(dialogController.text),
                etiqueta: etiqueta);
            if (retorno.codRetorno == 0) {
              loading(false);
              inputBarCode.clear();
              Get.back();
              focus.requestFocus();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              await getItensPedidoIndex();
              Get.back(closeOverlays: true);
              clear();
              await getItensPedido();
            }
            qtd.value = 1;
          } catch (e) {
            qtd.value = 1;
            inputBarCode.clear();
            message(MessageModel.error(message: 'barcodeErroConferencia'.tr));
          }
        },
      ),
    );
  }

  Future<BarCodeModel> setItensPedido({
    required ItensPedidoModel itemPedido,
    required double qtd,
    required String etiqueta,
  }) async {
    try {
      var retorno = await _barcodeViewModel.setItensPedido(
        codPed: infoLoteModel.value!.codPed!,
        item: itemPedido.item!,
        numCaixa: 0,
        codProd: int.parse(itemPedido.codProd!),
        pesoCx: qtd,
        codEtiqueta: etiqueta,
        usuarioCodeBar: await _storage.retornaUser(),
        qtdEtiq: 1,
      );
      inputBarCode.clear();
      return BarCodeModel(
          msgRetorno: retorno.msgRetorno, codRetorno: retorno.codRetorno);
    } catch (e) {
      return BarCodeModel(msgRetorno: 'barcodeErroLeitura'.tr, codRetorno: 0);
    }
  }
}
