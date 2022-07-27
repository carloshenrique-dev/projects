import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/ui/loader/loader_mixin.dart';
import 'package:up_afv/application/themes/ui/messages/app_messages.dart';
import 'package:up_afv/application/themes/ui/messages/messages_mixin.dart';
import 'package:up_afv/core/models/customers/customers_model.dart';
import 'package:up_afv/core/services/db/db_service.dart';

class CustomersController extends GetxController
    with LoaderMixin, MessagesMixin {
  final lista = <CustomersModel>[].obs;
  final _lista = <CustomersModel>[];
  final loading = false.obs;
  final DbService _dbService;
  final message = Rxn<MessageModel>();
  final clearButton = false.obs;
  final hintSearch = ''.obs;
  final filterBy = Rxn<int>();
  final route = ''.obs;
  final arguments = Rxn<dynamic>();
  TextEditingController textController = TextEditingController();
  FocusNode focus = FocusNode();

  CustomersController({
    required DbService dbService,
  }) : _dbService = dbService;

  @override
  Future<void> onReady() async {
    super.onReady();
    await carregaClientes();
    arguments.value = Get.arguments;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    await carregaFiltros();
  }

  getRoute(CustomersModel customer) {
    if (arguments.value != '' && arguments.value != null) {
      return Get.back(result: customer);
    } else {
      return Get.toNamed(
        '/aboutclient',
        arguments: customer,
      );
    }
  }

  void clearSearch() {
    textController.clear();
    if (filterBy.value == 0) {
      putOnName();
    } else if (filterBy.value == 1) {
      putOnRazao();
    } else if (filterBy.value == 2) {
      putOnCode();
    }
    clearButton(false);
  }

  void filterByName(String nome) {
    if (nome.isNotEmpty) {
      var newLista = _lista.where((value) {
        return value.commercialName!.toLowerCase().contains(nome.toLowerCase());
      });
      lista.assignAll(newLista);
    } else {
      lista.assignAll(_lista);
    }
  }

  void filterByCode(String code) {
    if (code.isNotEmpty) {
      var newLista = _lista.where((value) {
        return value.customerCode!.toString().contains(code);
      });
      lista.assignAll(newLista);
    } else {
      lista.assignAll(_lista);
    }
  }

  void filterByRazao(String razao) {
    if (razao.isNotEmpty) {
      var newLista = _lista.where((value) {
        return value.corporateName!.toLowerCase().contains(razao.toLowerCase());
      });
      lista.assignAll(newLista);
    } else {
      lista.assignAll(_lista);
    }
  }

  void choosePath(String value) {
    if (value != '') {
      clearButton(true);
    } else {
      clearButton(false);
    }
    if (filterBy.value == 0) {
      filterByName(value);
    } else if (filterBy.value == 1) {
      filterByRazao(value);
    } else {
      filterByCode(value);
    }
  }

  putOnName() async {
    hintSearch.value = 'byFantasy'.tr;
    final newLista = _lista
      ..sort((a, b) => a.commercialName!.compareTo(b.commercialName!));
    lista.assignAll(newLista);
    filterBy(0);
    await updateFilterBy(cod: 0);
    textFieldFocus();
  }

  putOnCode() async {
    hintSearch.value = 'byCod'.tr;
    final newLista = _lista
      ..sort((a, b) => a.customerCode!.compareTo(b.customerCode!));
    lista.assignAll(newLista);
    filterBy(2);
    await updateFilterBy(cod: 2);
    textFieldFocus();
  }

  putOnRazao() async {
    hintSearch.value = 'byReason'.tr;
    final newLista = _lista
      ..sort((a, b) => a.corporateName!.compareTo(b.corporateName!));
    lista.assignAll(newLista);
    filterBy(1);
    await updateFilterBy(cod: 1);
    textFieldFocus();
  }

  carregaClientes() async {
    loading(true);
    try {
      var retorno = await _dbService.queryClients();
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

  carregaFiltros() async {
    var config = await _dbService.retrieveDataConfig();
    filterBy.value = config[0].codFilterCli!;
  }

  updateFilterBy({required int cod}) async {
    await _dbService.updateData(
        value: 'codFilterCli', arguments: cod, table: 'config');
    await carregaFiltros();
  }
}
