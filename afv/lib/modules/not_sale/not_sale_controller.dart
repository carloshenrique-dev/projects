import 'dart:developer';
import 'package:get/get.dart';
import 'package:up_afv/core/models/not_sale/not_sale_model.dart';
import 'package:up_afv/core/view_models/not_sale/not_sale_view_model.dart';

class NotSaleController extends GetxController {
  final list = <NotSaleModel>[].obs;
  final NotSaleViewModel _notSaleViewModel;
  final selected = 'CLIENTE FECHADO'.obs;

  NotSaleController({
    required NotSaleViewModel notSaleViewModel,
  }) : _notSaleViewModel = notSaleViewModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getData();
  }

  Future<void> getData() async {
    try {
      var response = await _notSaleViewModel.queryNotSale();
      if (response.isNotEmpty) {
        list.assignAll(response);
      } else {
        list.assignAll([]);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  setSelected(String value) {
    selected.value = value;
  }
}
