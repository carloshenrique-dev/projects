import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:up_codebar/app/core/models/info_lote_model.dart';
import 'package:up_codebar/app/core/models/lotes_abertos_model.dart';
import 'package:up_codebar/app/core/view_models/lotes_abertos/lotes_abertos_list_view_model.dart';
import 'package:up_codebar/app/theme/styles/app_colors.dart';
import 'package:up_codebar/app/ui/loader/loader_mixin.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';

class LotesAbertosController extends GetxController
    with LoaderMixin, MessagesMixin {
  final LotesAbertosListViewModel _lotesAbertosListViewModel;
  final lotesAbertos = <LotesAbertosModel>[].obs;
  final arguments = ''.obs;
  final loading = false.obs;
  final message = Rxn<MessageModel>();

  LotesAbertosController({
    required LotesAbertosListViewModel lotesAbertosListViewModel,
  }) : _lotesAbertosListViewModel = lotesAbertosListViewModel;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getLotesAbertos();
  }

  Future<bool> getLotesAbertos() async {
    try {
      loading(true);
      final lotes = await _lotesAbertosListViewModel.getLotesAbertos();
      lotesAbertos.assignAll(lotes);
      loading(false);
      return true;
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'lotesAbertosErro'.tr));
      return false;
    }
  }

  void navigate(
      {dynamic arguments,
      String? statusLote,
      int? codLote,
      Map<String, String>? parameters}) {
    if (statusLote!.startsWith('N') && arguments == 'produto') {
      Get.toNamed(
        '/produto',
        parameters: parameters,
        arguments: codLote,
      );
    } else if (statusLote.startsWith('N') && arguments == 'pedido') {
      Get.toNamed(
        '/pedido',
        arguments: InfoLoteModel(
            codigo: codLote,
            itinerario: parameters!['itinerario'],
            veiculo: parameters['veiculo']),
      );
    } else {
      message(MessageModel.error(message: 'lotesAbertosLoteConferido'.tr));
    }
  }

  String formatData(data) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(data);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  Color cardColor(String? statusLote) {
    if (statusLote!.startsWith('N')) {
      return AppColors.orange;
    } else {
      return AppColors.greenCard;
    }
  }
}
