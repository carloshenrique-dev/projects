import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/models/barcode_scanner_model.dart';
import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/models/produto_model.dart';
import 'package:up_codebar/app/core/models/tipo_setor_estoque_model.dart';
import 'package:up_codebar/app/core/services/barcode_services.dart';
import 'package:up_codebar/app/core/services/storage_services.dart';
import 'package:up_codebar/app/core/view_models/barcode/barcode_view_model.dart';
import 'package:up_codebar/app/core/view_models/produto/produto_view_model.dart';
import 'package:up_codebar/app/ui/bottom_sheet/bottom_sheet_mixin.dart';
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';
import 'package:up_codebar/app/ui/slider/slider_mixin.dart';
import 'package:up_codebar/modules/lotes_abertos/lotes_abertos_controller.dart';

class ProdutoController extends GetxController
    with
        LoaderMixin,
        MessagesMixin,
        BarcodeServices,
        BottomSheetMixin,
        SliderMixin {
  final ProdutoViewModel _produtoViewModel;
  final BarcodeViewModel _barcodeViewModel;
  final LotesAbertosController _lotesAbertosController;
  final Storage _storage;
  TextEditingController inputBarCode = TextEditingController();
  final loading = false.obs;
  final hasText = false.obs;
  final valueCheckBox = false.obs;
  final message = Rxn<MessageModel>();
  final slider = Rxn<SliderModel>();
  final combo = <TipoSetorEstoqueModel>[].obs;
  final bottomSheet = Rxn<BottomSheetModel>();
  final comboItems = <ProdutoModel>[].obs;
  final items = <String>[].obs;
  var itemsLote = <ProdutoModel>[].obs;
  final codLote = 0.obs;
  final itinerario = ''.obs;
  final veiculo = ''.obs;
  final tipo = 0.obs;
  final qtd = 1.0.obs;
  final qtdLabel = '1'.obs;
  final visualizaCodebar = false.obs;
  final qtdFator = 1.0.obs;
  final pe = false.obs;
  var codebar = '';
  final codProd = 0.obs;
  FocusNode focus = FocusNode();

  ProdutoController({
    required ProdutoViewModel produtoViewModel,
    required BarcodeViewModel barcodeViewModel,
    required LotesAbertosController lotesAbertosController,
    required Storage storage,
  })  : _produtoViewModel = produtoViewModel,
        _barcodeViewModel = barcodeViewModel,
        _lotesAbertosController = lotesAbertosController,
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
    await getSetorEstoque();
    await getItensLote();
  }

  onFocusChange() {
    if (!focus.hasFocus && Get.isBottomSheetOpen == false) {
      focus.requestFocus();
    }
  }

  Future<bool> getLotesAbertos() async {
    return await _lotesAbertosController.getLotesAbertos();
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
        bool? retorno = await isLote();
        if (retorno != null && retorno == false) {
          message(MessageModel.error(message: 'barcodeCodigoNaoEncontrado'.tr));
          inputBarCode.clear();
        }
      }
    } catch (e) {
      inputBarCode.clear();
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
        bool? retorno = await isLote();
        if (retorno != null && retorno == false) {
          message(MessageModel.error(message: 'barcodeCodigoNaoEncontrado'.tr));
          inputBarCode.clear();
        }
      }
    } catch (e) {
      inputBarCode.clear();
      message(MessageModel.error(message: 'barcodeLeituraManual'.tr));
    }
  }

  //validacao do codigo lido + verificacao se existe o produto na lista para fazer a chamada da API (visao por produto)
  Future<bool?> isLote() async {
    String? etiqueta = codebar;
    double quantidade = 1.0;

    try {
      if (codebar.length == 38) {
        Map<String, dynamic> map = validaEtiquetaCodebar(codebar);
        etiqueta = map['codProd'] != null ? map['codProd']! : map['barcode']!;
        quantidade =
            map['qtd'] != null ? double.parse(map['qtd']!) / 1000 : 1.0;
        //validade = map['valido']!;
      }

      if (codebar.length == 13 && codebar.startsWith('2')) {
        Map<String, dynamic> map = validaEtiquetaPadaria(codebar);
        etiqueta = map['codProd'] != null ? map['codProd']! : map['barcode']!;
        quantidade =
            map['qtd'] != null ? double.parse(map['qtd']!) / 1000 : 1.0;
      }

      //if (validade == null || validade == 'valido') {
      for (var i = 0; i < itemsLote.length; i++) {
        //regra de negocio para leitura de etiqueta codebar
        if (codebar.length == 38 && etiqueta == itemsLote[i].codProd) {
          var retorno = await setItensLote(
              qtd: quantidade,
              codProduto: int.parse(itemsLote[i].codProd!),
              etiqueta: codebar);
          if (retorno.codRetorno == 0) {
            inputBarCode.clear();
            Get.toNamed('/erro', arguments: retorno.msgRetorno);
          } else {
            await getItensLoteIndex(itemsLote[i]);
          }
          return true;
        }
        //regra de negocio para leitura de etiqueta tipo padaria
        if (codebar.length == 13 &&
            codebar.startsWith('2') &&
            etiqueta == itemsLote[i].codProd) {
          var retorno = await setItensLote(
              qtd: quantidade,
              codProduto: int.parse(itemsLote[i].codProd!),
              etiqueta: codebar);
          if (retorno.codRetorno == 0) {
            inputBarCode.clear();
            Get.toNamed('/erro', arguments: retorno.msgRetorno);
          } else {
            await getItensLoteIndex(itemsLote[i]);
          }
          return true;
        }
        if (itemsLote[i].procodbar == etiqueta) {
          //regra de negocio para etiqueta normal produto
          //quando nao selecionado leitura continua e nao e etiqueta codebar(etiqueta de produto)
          if (valueCheckBox.value == false && codebar.length != 38) {
            pe.value = false;
            carregaComboFator(
              produto: itemsLote[i],
              etiqueta: etiqueta!,
            );
          }
          //quando o valor foi digitado ou lido e a leitura continua esta ativa
          else if (hasText.value == true && valueCheckBox.value == true) {
            var retorno = await setItensLote(
                qtd: quantidade,
                codProduto: int.parse(itemsLote[i].codProd!),
                etiqueta: etiqueta!);
            if (retorno.codRetorno == 0) {
              inputBarCode.clear();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              await getItensLoteIndex(itemsLote[i]);
            }
          }
          //leitura direta caso as condicoes nao sejam atendida
          else {
            var retorno = await setItensLote(
                qtd: quantidade,
                codProduto: int.parse(itemsLote[i].codProd!),
                etiqueta: etiqueta!);
            if (retorno.codRetorno == 0) {
              inputBarCode.clear();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              await getItensLoteIndex(itemsLote[i]);
              scanBarcode();
            }
          }
          return true;
        }
        if (itemsLote[i].procodbarPe == etiqueta) {
          //regra de negocio para etiqueta normal caixa
          //quando nao selecionado leitura continua e nao e etiqueta codebar (etiqueta de caixa)
          if (valueCheckBox.value == false && codebar.length != 38) {
            pe.value = true;
            carregaComboFator(
              produto: itemsLote[i],
              etiqueta: etiqueta!,
            );
          }
          //quando o valor foi digitado ou lido e a leitura continua esta ativa
          else if (hasText.value == true && valueCheckBox.value == true) {
            var retorno = await setItensLote(
                qtd: quantidade,
                codProduto: int.parse(itemsLote[i].codProd!),
                etiqueta: etiqueta!);
            if (retorno.codRetorno == 0) {
              inputBarCode.clear();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              await getItensLoteIndex(itemsLote[i]);
            }
          }
          //leitura direta caso as condicoes nao sejam atendidas
          else {
            var retorno = await setItensLote(
                qtd: quantidade,
                codProduto: int.parse(itemsLote[i].codProd!),
                etiqueta: etiqueta!);
            if (retorno.codRetorno == 0) {
              inputBarCode.clear();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              await getItensLoteIndex(itemsLote[i]);
              scanBarcode();
            }
          }
          return true;
        }
      }
      /*} else {
        inputBarCode.clear();
        Get.toNamed('/erro', arguments: 'validade'.tr);
        return true;
      }*/
      return false;
    } catch (e) {
      return false;
    }
  }

  //conferencia de itens do lote (chamada da API)-(visao por produto)
  Future<BarCodeModel> setItensLote(
      {required double qtd,
      required int codProduto,
      required String etiqueta}) async {
    try {
      var retorno = await _barcodeViewModel.setItensLote(
        codLote: codLote.value,
        codProd: codProduto,
        qtdDigitada: qtd,
        codEtiqueta: etiqueta,
        usuarioCodeBar: await _storage.retornaUser(),
      );
      inputBarCode.clear();
      return BarCodeModel(
          msgRetorno: retorno.msgRetorno, codRetorno: retorno.codRetorno);
    } catch (e) {
      return BarCodeModel(msgRetorno: 'barcodeErroGravacao'.tr, codRetorno: 0);
    }
  }

  //busca os setores de estoque (chamada da API)
  Future<void> getSetorEstoque() async {
    try {
      loading(true);
      final setoresEstoque =
          await _produtoViewModel.getTipoSetorEstoque(codLote: codLote.value);
      items.assignAll(setoresEstoque.map((e) => e.tipoSetor!));
      combo.assignAll(setoresEstoque);
      tipo.value = combo[0].tipo!;
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'produtoPageErroSetor'.tr));
    }
  }

  void convertDoubleValue() {
    qtdLabel.value = qtd.value.round().toString();
  }

  //dialogo da conferencia manual
  carregaComboFator(
      {required ProdutoModel produto, required String etiqueta}) async {
    String isPeText = '';
    if (pe.value) {
      isPeText =
          '${'qtdLida'.tr} ${produto.peUnid} = ${produto.peQtd} ${produto.unid}.\n${'insiraQtd'.tr} ${produto.peUnid}';
    } else {
      isPeText =
          '${'qtdLida'.tr} ${produto.fatorUn} = ${produto.fator} ${produto.unid}.\n${'insiraQtd'.tr} ${produto.fatorUn}';
    }

    if (produto.peQtd == 0 && pe.value == true) {
      isPeText = 'insiraQtd'.tr;
    }
    if (produto.fator == 0 && pe.value == false) {
      isPeText = 'insiraQtd'.tr;
    }

    slider(
      SliderModel(
        //isTextVisible: isTextVisible,
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
            var retorno = await setItensLote(
                qtd: qtd.value,
                codProduto: int.parse(produto.codProd!),
                etiqueta: etiqueta);
            if (retorno.codRetorno == 0) {
              loading(false);
              inputBarCode.clear();
              Get.back();
              focus.requestFocus();
              Get.toNamed('/erro', arguments: retorno.msgRetorno);
            } else {
              loading(false);
              await getItensLoteIndex(produto);
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
    focus.removeListener(() {});
    inputBarCode.clear();
  }

  //busca os itens do lote (chamada da API)
  Future<void> getItensLote() async {
    try {
      loading(true);
      final lista = await _produtoViewModel.getProdutos(
          codLote: codLote.value, tipoSetor: tipo.value);
      itemsLote.assignAll(lista);
      loading(false);
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'produtoPageErroItens'.tr));
    }
  }

  //reordena o index pos o item ser conferido
  Future<void> getItensLoteIndex(ProdutoModel produto) async {
    try {
      loading(true);
      final lista = await _produtoViewModel.getProdutos(
          codLote: codLote.value, tipoSetor: tipo.value);
      itemsLote.assignAll(lista);
      var item = itemsLote.firstWhere((element) =>
          element.codProd == produto.codProd && element.item == produto.item);
      int index = itemsLote.indexOf(item);
      itemsLote.removeAt(index);
      itemsLote.insert(0, lista[index]);
      loading(false);
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'produtoPageErroItens'.tr));
    }
  }

  //limpa a conferencia dos itens
  Future<DefaultReturnModel> deleteItensLote(
      {required ProdutoModel produtoModel}) async {
    try {
      loading(true);
      final retornoDelete = await _produtoViewModel.deleteItensLote(
          codLote: codLote.value,
          codProd: int.tryParse(produtoModel.codProd!)!);
      loading(false);
      return DefaultReturnModel(
          msgRetorno: retornoDelete.msgRetorno,
          codRetorno: retornoDelete.codRetorno);
    } catch (e) {
      loading(false);
      return DefaultReturnModel(codRetorno: 0, msgRetorno: 'serverError'.tr);
    }
  }

  Future<void> limpaItem({required ProdutoModel produtoModel}) async {
    bottomSheet(
      BottomSheetModel(
        onConfirm: () async {
          loading(true);
          try {
            if (produtoModel.qtdConfFat != 0) {
              var retorno = await deleteItensLote(produtoModel: produtoModel);
              if (retorno.codRetorno == 0) {
                loading(false);
                message(MessageModel.error(message: 'barcodeErroLimpeza'.tr));
              } else if (retorno.codRetorno == 1) {
                await getItensLote();
                loading(false);
                Get.back();
                message(
                    MessageModel.sucess(message: 'barcodeSucessoLimpeza'.tr));
              } else {
                loading(false);
                message(MessageModel.error(message: 'barcodeErroLimpeza'.tr));
              }
            } else {
              loading(false);
              message(MessageModel.error(message: 'barcodeLimpezaQtd'.tr));
            }
          } catch (e) {
            message(MessageModel.error(message: 'barcodeErroConferencia'.tr));
          }
        },
      ),
    );
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
      var isVisible =
          await _storage.genericReadStorage(key: 'visualizaCodebar');
      if (isVisible != '') {
        visualizaCodebar.value = isVisible;
      } else {
        visualizaCodebar.value = false;
      }
    } catch (e) {
      message(MessageModel.error(message: 'errorReadConfigs'.tr));
    }
  }
}
