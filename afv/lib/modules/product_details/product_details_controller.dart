import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/ui/loader/loader_mixin.dart';
import 'package:up_afv/application/themes/ui/messages/messages_mixin.dart';
import 'package:up_afv/application/themes/ui/price_list_bottom_sheet/price_list_bottom_sheet_mixin.dart';
import 'package:up_afv/core/models/products/price_list_db_model.dart';
import 'package:up_afv/core/models/products/prod_model.dart';
import 'package:up_afv/core/view_models/products/produtos_view_model.dart';

class ProductDetailsController extends GetxController
    with PriceListBottomSheetMixin, LoaderMixin, MessagesMixin {
  final bottomSheet = Rxn<PriceListBottomSheetModel>();
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  var visibility = true.obs;
  final list = <PriceListDbModel>[].obs;
  final ProductsViewModel _productsViewModel;
  ProdModel prod = ProdModel();

  ProductDetailsController({required ProductsViewModel productsViewModel})
      : _productsViewModel = productsViewModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    bottomSheetListener(bottomSheet);
    loaderListener(loading);
    messageListener(message);
    prod = Get.arguments;
    await getPricesList();
  }

  Future<void> getPricesList() async {
    try {
      var pricesList =
          await _productsViewModel.queryPricesList(productCode: prod.codProd!);
      list.assignAll(pricesList);
    } catch (e) {
      log(e.toString());
    }
  }

  showPriceList(
      {required BuildContext context, required PriceListDbModel priceList}) {
    double fator = priceList.salePrice! * prod.fator!;
    double pe = priceList.salePrice! * prod.peQtd!;

    bottomSheet(
      PriceListBottomSheetModel(
        context: context,
        priceListDbModel: priceList,
        prodModel: prod,
        factor: fator.toStringAsFixed(2),
        pe: pe.toStringAsFixed(2),
        isFactorVisible: pe != 0.0 ? true : false,
        isPeVisible: fator != 0.0 ? true : false,
      ),
    );
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  switchVisibility() {
    visibility.value = !visibility.value;
  }
}
