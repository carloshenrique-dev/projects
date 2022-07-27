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
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';
import 'package:up_codebar/app/ui/slider/slider_mixin.dart';
import 'package:up_codebar/modules/pedido/pedido_controller.dart';

class ItensPedidoController extends GetxController
    with
        LoaderMixin,
        MessagesMixin,
        BarcodeServices,
        BottomSheetMixin,
        SliderMixin {
  final PedidoViewModel _pedidoViewModel;
  final BarcodeViewModel _barcodeViewModel;
  final PedidoController _pedidoController;
  final Storage _storage;
  TextEditingController inputBarCode = TextEditingController();
  final loading = false.obs;
  final hasText = false.obs;
  final valueCheckBox = false.obs;
  final isAmountControlEnabled = false.obs;
  final infoLoteModel = Rxn<InfoLoteModel>();
  final bottomSheet = Rxn<BottomSheetModel>();
  final slider = Rxn<SliderModel>();
  final message = Rxn<MessageModel>();
  final itemsPedido = <ItensPedidoModel>[].obs;
  final visualizaCodebar = false.obs;
  final qtd = 1.0.obs;
  final qtdLabel = '1'.obs;
  final pe = false.obs;
  final qtdFator = 1.0.obs;
  var codebar = '';
  FocusNode focus = FocusNode();

  ItensPedidoController({
    required PedidoViewModel pedidoViewModel,
    required BarcodeViewModel barcodeViewModel,
    required PedidoController pedidoController,
    required Storage storage,
  })  : _pedidoViewModel = pedidoViewModel,
        _barcodeViewModel = barcodeViewModel,
        _pedidoController = pedidoController,
        _storage = storage;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    bottomSheetListener(bottomSheet);
    bottomSheetSliderListener(slider);
    focus.addListener(onFocusChange);
    focus.requestFocus();
    infoLoteModel(Get.arguments);
    readConfigs();
  }

  @override
  void onClose() {
    super.onClose();
    clear();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getItensPedido();
  }

  comeBackPage() {
    focus.addListener(onFocusChange);
    focus.requestFocus();
  }

  onFocusChange() {
    if (!focus.hasFocus && Get.isBottomSheetOpen == false) {
      focus.requestFocus();
    }
  }

  Future<bool> getPedidosLote() async {
    return await _pedidoController.getPedidosLote();
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

  void add() {
    qtd.value++;
    update();
  }

  void minus() {
    if (qtd.value != 0) {
      qtd.value--;
      update();
    }
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

  //validacao do codigo lido + verificacao se existe o produto na lista para fazer a chamada da API (visao por pedido)
  Future<bool?> isPedido() async {
    String? etiqueta = codebar;
    double quantidade = 1;

    try {
      if (codebar.length == 38) {
        Map<String, dynamic> map = validaEtiquetaCodebar(codebar);
        etiqueta = map['codProd'] != null ? map['codProd']! : map['barcode']!;
        quantidade =
            map['qtd'] != null ? double.parse(map['qtd']!) / 1000 : 1.0;
      }

      if (codebar.length == 13 && codebar.startsWith('2')) {
        Map<String, dynamic> map = validaEtiquetaPadaria(codebar);
        etiqueta = map['codProd'] != null ? map['codProd']! : map['barcode']!;
        quantidade =
            map['qtd'] != null ? double.parse(map['qtd']!) / 1000 : 1.0;
      }

      //if (validade == null || validade == 'valido') {
      for (var i = 0; i < itemsPedido.length; i++) {
        //regra personalizada RD
        if (codebar.length == 38 &&
            etiqueta == itemsPedido[i].codProd &&
            isAmountControlEnabled.value) {
          var retorno = await setItensPedido(
              qtd: quantidade, itemPedido: itemsPedido[i], etiqueta: codebar);
          if (retorno.codRetorno == 0) {
            inputBarCode.clear();
            Get.toNamed('/erro', arguments: retorno.msgRetorno);
          } else {
            clear();
            Get.toNamed(
              '/customizations',
              arguments: [
                itemsPedido[i],
                InfoLoteModel(
                  codigo: infoLoteModel.value!.codigo,
                  itinerario: infoLoteModel.value!.itinerario,
                  veiculo: infoLoteModel.value!.veiculo,
                  codPed: infoLoteModel.value!.codPed,
                ),
              ],
              preventDuplicates: true,
            );
          }
          return true;
        }

        //regra de negocio para leitura de etiqueta codebar
        if (codebar.length == 38 && etiqueta == itemsPedido[i].codProd) {
          var retorno = await setItensPedido(
              qtd: quantidade, itemPedido: itemsPedido[i], etiqueta: codebar);
          if (retorno.codRetorno == 0) {
            inputBarCode.clear();
            Get.toNamed('/erro', arguments: retorno.msgRetorno);
          } else {
            await getItensPedidoIndex(itemsPedido[i]);
          }
          return true;
        }

        //regra de negocio para leitura de etiqueta tipo padaria
        if (codebar.length == 13 &&
            codebar.startsWith('2') &&
            etiqueta == itemsPedido[i].codProd) {
          var retorno = await setItensPedido(
              qtd: quantidade, itemPedido: itemsPedido[i], etiqueta: codebar);
          if (retorno.codRetorno == 0) {
            inputBarCode.clear();
            Get.toNamed('/erro', arguments: retorno.msgRetorno);
          } else {
            await getItensPedidoIndex(itemsPedido[i]);
          }
          return true;
        }

        if (itemsPedido[i].procodbar == etiqueta) {
          //regra de negocio para etiqueta normal produto
          //quando nao selecionado leitura continua e nao e etiqueta codebar(etiqueta de produto)
          if (valueCheckBox.value == false && codebar.length != 38) {
            pe.value = false;
            await carregaComboFator(
              itemPedido: itemsPedido[i],
              etiqueta: etiqueta!,
            );
          }
          //quando o valor foi digitado ou lido e a leitura continua esta ativa
          else if (hasText.value == true && valueCheckBox.value == true) {
            var retorno = await setItensPedido(
                itemPedido: itemsPedido[i],
                qtd: quantidade,
                etiqueta: etiqueta!);
            if (retorno.codRetorno == 0) {
              inputBarCode.clear();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              await getItensPedidoIndex(itemsPedido[i]);
            }
          }
          //leitura direta caso as condicoes nao sejam atendidas
          else {
            var retorno = await setItensPedido(
                itemPedido: itemsPedido[i],
                qtd: quantidade,
                etiqueta: etiqueta!);
            if (retorno.codRetorno == 0) {
              inputBarCode.clear();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              await getItensPedidoIndex(itemsPedido[i]);
              scanBarcode();
            }
          }
          return true;
        }
        if (itemsPedido[i].procodbarpe == etiqueta) {
          //regra de negocio para etiqueta normal caixa
          //quando nao selecionado leitura continua e nao e etiqueta codebar (etiqueta de caixa)
          if (valueCheckBox.value == false && codebar.length != 38) {
            pe.value = true;

            await carregaComboFator(
              itemPedido: itemsPedido[i],
              etiqueta: etiqueta!,
            );
          }
          //quando o valor foi digitado ou lido e a leitura continua esta ativa
          else if (hasText.value == true && valueCheckBox.value == true) {
            var retorno = await setItensPedido(
                itemPedido: itemsPedido[i],
                qtd: quantidade,
                etiqueta: etiqueta!);
            if (retorno.codRetorno == 0) {
              inputBarCode.clear();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              await getItensPedidoIndex(itemsPedido[i]);
            }
          }
          //leitura direta caso as condicoes nao sejam atendidas
          else {
            var retorno = await setItensPedido(
                itemPedido: itemsPedido[i],
                qtd: quantidade,
                etiqueta: etiqueta!);
            if (retorno.codRetorno == 0) {
              inputBarCode.clear();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              await getItensPedidoIndex(itemsPedido[i]);
              scanBarcode();
            }
          }
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  //conferencia de itens do pedido (chamada da API)-(visao por produto)
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
        qtdEtiq: 1, //ver na proc isso aqui
      );
      inputBarCode.clear();
      return BarCodeModel(
          msgRetorno: retorno.msgRetorno, codRetorno: retorno.codRetorno);
    } catch (e) {
      return BarCodeModel(msgRetorno: 'barcodeErroLeitura'.tr, codRetorno: 0);
    }
  }

  void convertDoubleValue() {
    qtdLabel.value = qtd.value.round().toString();
  }

  Future<void> carregaComboFator(
      {required ItensPedidoModel itemPedido, required String etiqueta}) async {
    String isPeText = '';
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
    }

    slider(
      SliderModel(
        add: () => add(),
        remove: () => minus(),
        qtd: qtd,
        text: isPeText,
        label: qtd,
        onCancel: () {
          inputBarCode.clear();
          Get.back();
          focus.requestFocus();
        },
        onConfirm: () async {
          loading(true);
          try {
            var retorno = await setItensPedido(
                itemPedido: itemPedido, qtd: qtd.value, etiqueta: etiqueta);
            if (retorno.codRetorno == 0) {
              loading(false);
              inputBarCode.clear();
              Get.back();
              focus.requestFocus();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              loading(false);
              await getItensPedidoIndex(itemPedido);
              Get.back();
              focus.requestFocus();
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

  clear() {
    focus.removeListener(onFocusChange);
    inputBarCode.clear();
    focus.unfocus();
  }

  //busca os itens do pedido (chamada da API)
  Future<bool> getItensPedido() async {
    try {
      loading(true);
      final lista = await _pedidoViewModel.getItensPedido(
          codPed: infoLoteModel.value!.codPed!);
      itemsPedido.assignAll(lista);
      loading(false);
      return true;
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'itensPedidoGetItens'.tr));
      return false;
    }
  }

  //reordena o index pos o item ser conferido
  Future<void> getItensPedidoIndex(ItensPedidoModel itemPedido) async {
    try {
      loading(true);
      final lista = await _pedidoViewModel.getItensPedido(
          codPed: infoLoteModel.value!.codPed!);
      itemsPedido.assignAll(lista);
      var item = itemsPedido.firstWhere((element) =>
          element.codProd == itemPedido.codProd &&
          element.item == itemPedido.item);
      int index = itemsPedido.indexOf(item);
      itemsPedido.removeAt(index);
      itemsPedido.insert(0, lista[index]);
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
                Get.back();
                await getItensPedido();
                loading(false);
                message(
                    MessageModel.sucess(message: 'barcodeSucessoLimpeza'.tr));
              } else {
                loading(false);
                message(MessageModel.error(message: 'barcodeErroLimpeza'.tr));
              }
            } catch (e) {
              message(MessageModel.error(message: 'barcodeErroConferencia'.tr));
            }
          },
        ),
      );
    } else {
      loading(false);
      message(MessageModel.error(message: 'barcodeLimpezaQtd'.tr));
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

  void readConfigs() async {
    try {
      Future.wait([
        readCodebarConfig(),
        readAmountControlConfig(),
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

  Future readAmountControlConfig() async {
    var amountControl =
        await _storage.genericReadStorage(key: 'enableAmountControl');
    if (amountControl != '') {
      isAmountControlEnabled.value = amountControl;
    } else {
      isAmountControlEnabled.value = false;
    }
  }
}
