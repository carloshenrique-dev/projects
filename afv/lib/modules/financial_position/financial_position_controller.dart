import 'dart:developer';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/ui/loader/loader_mixin.dart';
import 'package:up_afv/application/themes/ui/messages/messages_mixin.dart';
import 'package:up_afv/core/models/customers/customers_model.dart';
import 'package:up_afv/core/models/customers/financial_positions_items_model.dart';
import 'package:up_afv/core/view_models/customers/customers_view_model.dart';

class FinancialPositionController extends GetxController
    with MessagesMixin, LoaderMixin {
  var customer = CustomersModel();
  final list = <FinancialPositionsItemsModel>[].obs;
  final CustomersViewModel _customersViewModel;
  final loading = false.obs;
  final message = Rxn<MessageModel>();

  FinancialPositionController({
    required CustomersViewModel customersViewModel,
  }) : _customersViewModel = customersViewModel;

  @override
  onInit() async {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    customer = Get.arguments;
    await getData();
  }

  Future<void> getData() async {
    try {
      var financialPosition = await _customersViewModel
          .getFinancialPosition(customer.customerCode ?? 0);
      list.assignAll(financialPosition);
    } catch (e) {
      log(e.toString());
    }
  }
}
