import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/ui/loader/loader_mixin.dart';
import 'package:up_afv/application/themes/ui/messages/app_messages.dart';
import 'package:up_afv/application/themes/ui/messages/messages_mixin.dart';
import 'package:up_afv/core/models/products/prod_model.dart';
import 'package:up_afv/core/services/db/db_service.dart';
import 'package:up_afv/core/view_models/products/produtos_view_model.dart';

class ProductsController extends GetxController
    with MessagesMixin, LoaderMixin {
  final lista = <ProdModel>[].obs;
  final _lista = <ProdModel>[];
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final hintSearch = ''.obs;
  final filterBy = Rxn<int>();
  final clearButton = false.obs;
  TextEditingController textController = TextEditingController();
  FocusNode focus = FocusNode();
  final DbService _dbService;
  final ProductsViewModel _productsViewModel;

  ProductsController({
    required DbService dbService,
    required ProductsViewModel productsViewModel,
  })  : _dbService = dbService,
        _productsViewModel = productsViewModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    await carregaFiltros();
  }

  @override
  Future<void> onReady() async {
    await carregaProdutos();
  }

  void clearSearch() {
    textController.clear();
    if (filterBy.value == 0) {
      putOnCode();
    } else if (filterBy.value == 1) {
      putOnClass();
    } else if (filterBy.value == 2) {
      putOnDescription();
    }
    clearButton(false);
  }

  Future carregaFiltros() async {
    var config = await _dbService.retrieveDataConfig();
    filterBy.value = config[0].codFilterProd!;
  }

  void filterByDescription(String description) {
    if (description.isNotEmpty) {
      var newLista = _lista.where((value) {
        return value.descricao!
            .toLowerCase()
            .contains(description.toLowerCase());
      });
      lista.assignAll(newLista);
    } else {
      lista.assignAll(_lista);
    }
  }

  void filterByCode(String code) {
    if (code.isNotEmpty) {
      var newLista = _lista.where((value) {
        return value.codProd!.toString().contains(code);
      });
      lista.assignAll(newLista);
    } else {
      lista.assignAll(_lista);
    }
  }

  void filterByClasse(String classe) {
    if (classe.isNotEmpty) {
      var newLista = _lista.where((value) {
        return value.classe!.toString().contains(classe.toLowerCase());
      });
      lista.assignAll(newLista);
    } else {
      lista.assignAll(_lista);
    }
  }

  Future<void> putOnDescription() async {
    hintSearch.value = 'byDesc'.tr;
    final newLista = _lista
      ..sort((a, b) => a.descricao!.compareTo(b.descricao!));
    lista.assignAll(newLista);
    filterBy(2);
    await updateFilterBy(cod: 2);
    textFieldFocus();
  }

  Future<void> putOnCode() async {
    hintSearch.value = 'byCod'.tr;
    final newLista = _lista..sort((a, b) => a.codProd!.compareTo(b.codProd!));
    lista.assignAll(newLista);
    filterBy(0);
    await updateFilterBy(cod: 0);
    textFieldFocus();
  }

  Future<void> putOnClass() async {
    hintSearch.value = 'byClass'.tr;
    final newLista = _lista..sort((a, b) => a.classe!.compareTo(b.classe!));
    lista.assignAll(newLista);
    filterBy(1);
    await updateFilterBy(cod: 1);
    textFieldFocus();
  }

  void choosePath(String value) {
    if (value != '') {
      clearButton(true);
    } else {
      clearButton(false);
    }

    if (filterBy.value == 0) {
      filterByCode(value);
    } else if (filterBy.value == 1) {
      filterByClasse(value);
    } else {
      filterByDescription(value);
    }
  }

  Future carregaProdutos() async {
    try {
      loading(true);
      var retorno = await _productsViewModel.queryProducts();
      lista.assignAll(retorno);
      _lista.assignAll(retorno);
      loading(false);
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: AppMessages.errorProd));
    }
  }

  textFieldFocus() {
    textController.clear();
    focus.unfocus();
    /*Future.delayed(const Duration(milliseconds: 500), () {
      focus.requestFocus();
    });*/
  }

  updateFilterBy({required int cod}) async {
    await _dbService.updateData(
        value: 'codFilterProd', arguments: cod, table: 'config');
    await carregaFiltros();
  }
}
