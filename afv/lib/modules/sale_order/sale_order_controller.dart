import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:up_afv/application/themes/ui/loader/loader_mixin.dart';
import 'package:up_afv/application/themes/ui/messages/app_messages.dart';
import 'package:up_afv/application/themes/ui/messages/messages_mixin.dart';
import 'package:up_afv/core/models/customers/customers_model.dart';
import 'package:up_afv/core/models/products_order/products_order_model.dart';
import 'package:up_afv/core/services/db/db_service.dart';
import 'package:up_afv/core/view_models/products/produtos_view_model.dart';

class SaleOrderController extends GetxController
    with MessagesMixin, LoaderMixin {
  TextEditingController obsController = TextEditingController();
  List<TextEditingController> productsControllers = [];
  TextEditingController textController = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()).toString());
  var selectedDate = DateTime.now().subtract(const Duration(days: 0)).obs;
  var selectedTime = TimeOfDay.now().obs;
  var page = 0.obs;
  var customer = Rxn<CustomersModel>();
  var customerName = 'Selecione um cliente'.obs;
  var formKey = GlobalKey<ScaffoldState>();
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final hintSearch = ''.obs;
  final filterBy = Rxn<int>();
  final clearButton = false.obs;
  FocusNode focus = FocusNode();
  final products = <ProductsOrderModel>[].obs;
  final ProductsViewModel _productsViewModel;
  final pageList = 0.obs;

  SaleOrderController({
    required DbService dbService,
    required ProductsViewModel productsViewModel,
  }) : _productsViewModel = productsViewModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  @override
  Future<void> onReady() async {
    await carregaProdutos();
  }

  handleDataFromSecondPage() async {
    var data = await Get.toNamed(
      '/customers',
      arguments: '/saleorder',
    );
    if (data != null && data != '') {
      customer.value = data;
      customerName.value = customer.value!.commercialName!;
    }
  }

  Future carregaProdutos() async {
    try {
      loading(true);
      var retorno = await _productsViewModel.queryProductsOrder();
      if (retorno.isNotEmpty) {
        products.assignAll(retorno);
      } else {
        products([]);
      }
      loading(false);
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: AppMessages.errorProd));
    }
  }

  void clearSearch() {
    textController.clear();
    if (filterBy.value == 0) {
      //putOnCode();
    } else if (filterBy.value == 1) {
      //putOnClass();
    } else if (filterBy.value == 2) {
      //putOnDescription();
    }
    clearButton(false);
  }

  navigationBar(int value) {
    page.value = value;
  }

  void selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2023),
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      useRootNavigator: false,
      fieldHintText: 'dd/mm/yyyy',
      fieldLabelText: 'Insira uma data',
      helpText: 'Selecione uma data',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateController.text =
          DateFormat('dd/MM/yyyy').format(selectedDate.value).toString();
    }
  }

  void incrementItem(ProductsOrderModel product, int index) {
    int controllerValue = 0;
    if (productsControllers[index].text != '') {
      controllerValue = int.parse(productsControllers[index].text);
    }
    for (var item in products) {
      if (item == product) {
        int sum = controllerValue + 1;
        products[index].quantity = sum;
        productsControllers[index].text = sum.toString();
      }
    }
  }

  void subtractItem(ProductsOrderModel product, int index) {
    int controllerValue = 0;
    if (productsControllers[index].text != '') {
      controllerValue = int.parse(productsControllers[index].text);
    }
    for (var item in products) {
      if (item == product) {
        if (controllerValue != 0) {
          int subtract = controllerValue - 1;
          products[index].quantity = subtract;
          productsControllers[index].text = subtract.toString();
        }
      }
    }
  }
}
