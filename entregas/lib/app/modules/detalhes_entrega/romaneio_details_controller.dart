import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/models/item_romaneio/romaneio_itens.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/services/localization_firestore.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:intl/intl.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';
import 'package:upentregas/app/shared/ui/bottom_sheet/bottom_sheet_mixin.dart';
import 'package:upentregas/app/shared/ui/loader/loader_mixin.dart';
import 'package:upentregas/app/shared/ui/messages/messages_mixin.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class RomaneioDetailsController extends GetxController
    with LoaderMixin, MessagesMixin, LocalizationFirestore, BottomSheetMixin {
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final bottomSheet = Rxn<BottomSheetModel>();
  RomaneioItens? item;
  final romaneioId = 0.obs;
  final currentStep = 0.obs;
  final dataEntrega = '-'.obs;
  final dataRotaEntrega = '-'.obs;
  final detalhesDaEntrega = {}.obs;
  final latitude = ''.obs;
  final longitude = ''.obs;
  List<String> appSteps =
      <String>['startat'.tr, 'inProgress'.tr, 'endat'.tr].obs;
  StreamSubscription<Position>? getStreamSubscription;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    bottomSheetListener(bottomSheet);
    initializeDateFormatting('pt_BR', null);
    retornaInfos();
  }

  @override
  void onReady() {
    super.onReady();
    detalhesDaEntrega.bindStream(streamEntrega());
    getStreamSubscription = Geolocator.getPositionStream().listen((event) {
      latitude.value = event.latitude.toString();
      longitude.value = event.longitude.toString();
    });
  }

  @override
  void onClose() {
    super.onClose();
    detalhesDaEntrega.close();
    getStreamSubscription?.cancel();
  }

  retornaInfos() {
    romaneioId.value = int.parse(Get.parameters['romaneioId']!);
    item = Get.arguments;
  }

  Stream<Map> streamEntrega() {
    return content.firebaseContent.db!
        .collection('Romaneios')
        .doc('$romaneioId')
        .collection('Itens')
        .doc(item!.id)
        .snapshots()
        .map((item) {
      return {
        'rotaEntrega': item['rotaEntrega'] ?? false,
        'entregaConcluida': item['entregaConcluida'] ?? false,
        'dataEntrega': item['dataEntrega'] ?? '-',
        'dataRotaEntrega': item['dataRotaEntrega'] ?? '-',
      };
    });
  }

  Future<List<String>> verificaPendencia() async {
    List<String> ids = [];
    var snapshot = await content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romaneioId.toString())
        .collection('Itens')
        .get();
    for (var doc in snapshot.docs) {
      ids.add(
          '${doc['rotaEntrega'].toString()}|${doc['entregaConcluida'].toString()}|${doc['codPed'].toString()}');
    }
    return ids;
  }

  void deliverieStep() {
    if (detalhesDaEntrega['entregaConcluida'] == false &&
        detalhesDaEntrega['rotaEntrega'] == false) {
      currentStep.value = 0;
    } else if (detalhesDaEntrega['entregaConcluida'] == false &&
        detalhesDaEntrega['rotaEntrega'] == true) {
      currentStep.value = 1;
    } else if (detalhesDaEntrega['entregaConcluida'] == true &&
        detalhesDaEntrega['rotaEntrega'] == true) {
      currentStep.value = 2;
    } else if (detalhesDaEntrega['rotaEntrega'] == true) {
      currentStep.value = 1;
    } else {
      currentStep.value = 0;
    }
  }

  formatDate(BuildContext context) {
    if (detalhesDaEntrega['dataEntrega'] != '-' &&
        (detalhesDaEntrega['dataEntrega'] != null)) {
      dataEntrega.value =
          formatTimeStamp(detalhesDaEntrega['dataEntrega'], context);
    }
    if (detalhesDaEntrega['dataRotaEntrega'] != '-' &&
        detalhesDaEntrega['dataRotaEntrega'] != null) {
      dataRotaEntrega.value =
          formatTimeStamp(detalhesDaEntrega['dataRotaEntrega'], context);
    }

    if (dataEntrega.value == '00:00') {
      dataEntrega.value = '-';
    }

    if (dataRotaEntrega.value == '00:00') {
      dataRotaEntrega.value = '-';
    }
    appSteps = [
      '${'startat'.tr}\n${dataRotaEntrega.value}',
      'inProgress'.tr,
      '${'endat'.tr}\n${dataEntrega.value}'
    ];
  }

  String formatTimeStamp(Timestamp timestamp, BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    DateFormat dateFormat = DateFormat.Hm(languageCode);
    var dateTime = dateFormat.format(timestamp.toDate());
    return dateTime;
  }

  Future<void> startDeliverie() async {
    loading(true);
    try {
      bool? romaneioIniciado = await isRomaneioIniciado(romaneioId.value);

      var verificacao = await verificaPendencia();
      var element = 'true';
      bool isEntrega = false;
      for (var itens in verificacao) {
        var dados = itens.split('|');
        var rota = dados[0];
        var entrega = dados[1];
        var codPed = dados[2];
        if (rota.contains(element) &&
            (entrega.contains('false') || entrega.contains('null')) &&
            (codPed != item!.codPed.toString())) {
          isEntrega = true;
        }
      }

      if (isEntrega) {
        loading(false);
        message(MessageModel.error(message: 'deliveriesInProgress'.tr));
      } else {
        if (romaneioIniciado!) {
          await updateInicioEntrega(
            seq: item!.seq!,
            map: {
              'romId': romaneioId.value,
              'codFil': item!.codFil,
              'codPed': item!.codPed,
              'tipoDocto': item!.tipoDocto,
              'serie': item!.serie,
              'rotaEntrega': true,
              'dataRotaEntrega': Timestamp.fromDate(DateTime.now()),
              'latitude': latitude.value,
              'longitude': longitude.value,
            },
          );
          await updateLocalizacaoEntrega(
            romId: romaneioId.value,
            item: int.parse(item!.id!),
            latitude: latitude.value,
            longitude: longitude.value,
          );
          loading(false);
          message(MessageModel.sucess(message: 'deliverieStarted'.tr));
          callPhone();
        } else {
          loading(false);
          message(MessageModel.error(message: 'startRomaneio'.tr));
        }
      }
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'hasError'.tr));
    }
  }

  void endDeliverie() {
    Get.toNamed('/fimentrega', parameters: {
      'title': item!.cliente!['NomeFantasia'],
      'romId': '$romaneioId',
      'idItem': item!.id!,
      'codPed': item!.codPed.toString(),
    });
  }

  Future<void> reaberturaEntrega(BuildContext context) async {
    loading(true);
    try {
      bool reabertura = await updateReaberturaEntrega(
          isRota: true,
          romId: romaneioId.value,
          seq: item!.seq!,
          map: {
            'romId': romaneioId.value,
            'codFil': item!.codFil,
            'codPed': item!.codPed,
            'tipoDocto': item!.tipoDocto,
            'serie': item!.serie,
          });
      if (reabertura) {
        loading(false);
        message(MessageModel.sucess(message: 'reopenedDelivery'.tr));
      } else {
        loading(false);
        message(MessageModel.error(message: 'hasError'.tr));
      }
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'hasError'.tr));
    }
  }

  void navegacao() {
    bottomSheet(
      BottomSheetModel(
        btnLeftTitle: 'Google Maps',
        colorBtnLeft: AppColors.whiteColor,
        iconBtnLeft: FontAwesomeIcons.mapMarkerAlt,
        btnRightTitle: 'Waze',
        colorBtnRight: AppColors.whiteColor,
        iconBtnRight: FontAwesomeIcons.waze,
        btnFnLeft: () async {
          var fallbackUrl =
              'https://www.google.com.br/maps/dir/${latitude.value},${longitude.value}/${item!.enderecoEntrega!['logradouro']},+${item!.enderecoEntrega!['numero']},+${item!.enderecoEntrega!['cidade']}+-+${item!.enderecoEntrega!['UF']}';

          try {
            bool launched = await launch(fallbackUrl,
                forceWebView: false, forceSafariVC: false);
            if (!launched) {
              await launch(fallbackUrl,
                  forceSafariVC: false, forceWebView: false);
            }
          } catch (e) {
            await launch(fallbackUrl,
                forceWebView: false, forceSafariVC: false);
          }
        },
        btnFnRight: () async {
          var url =
              'waze://?q=${item!.enderecoEntrega!['logradouro']},${item!.enderecoEntrega!['numero']},${item!.enderecoEntrega!['cidade']}-${item!.enderecoEntrega!['UF']}&ll=${latitude.value.toString()},%${latitude.value.toString()}';
          var fallbackUrl =
              'https://waze.com/ul?q=${item!.enderecoEntrega!['logradouro']},${item!.enderecoEntrega!['numero']},${item!.enderecoEntrega!['cidade']}-${item!.enderecoEntrega!['UF']}&ll=${latitude.value.toString()},%${latitude.value.toString()}&navigate=yes';
          try {
            bool launched =
                await launch(url, forceSafariVC: false, forceWebView: false);
            if (!launched) {
              await launch(fallbackUrl,
                  forceSafariVC: false, forceWebView: false);
            }
          } catch (e) {
            await launch(fallbackUrl,
                forceSafariVC: false, forceWebView: false);
          }
        },
      ),
    );
  }

  void callPhone() {
    String telefone = item?.cliente?['telefones'] ?? '';
    String formatedPhone = telefone.replaceAll(RegExp(r'[^\w\s]+'), '');
    if (formatedPhone != '' && formatedPhone.isPhoneNumber) {
      bottomSheet(
        BottomSheetModel(
          iconBtnLeft: FontAwesomeIcons.phone,
          iconBtnRight: FontAwesomeIcons.whatsapp,
          btnRightTitle: 'WhatsApp',
          btnLeftTitle: 'phone'.tr,
          colorBtnLeft: AppColors.darkGreen,
          colorBtnRight: AppColors.darkGreen,
          btnFnLeft: () async {
            var link = 'tel://$formatedPhone';
            try {
              bool launched = await launch(link);
              if (!launched) {
                await launch(link);
              }
            } catch (e) {
              await launch(link);
            }
          },
          btnFnRight: () async {
            var link =
                'https://wa.me/55$formatedPhone?text=${greetingMessage()}, ${'weGoing'.tr} 🚚🥳😁';
            try {
              bool launched =
                  await launch(link, forceSafariVC: false, forceWebView: false);
              if (!launched) {
                await launch(link, forceSafariVC: false, forceWebView: false);
              }
            } catch (e) {
              await launch(link, forceSafariVC: false, forceWebView: false);
            }
          },
        ),
      );
    }
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;
    String greeting = '';

    if (timeNow <= 12) {
      greeting = 'morning'.tr;
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      greeting = 'afternoon'.tr;
    } else if ((timeNow > 16) && (timeNow < 20)) {
      greeting = 'evening'.tr;
    } else {
      greeting = 'night'.tr;
    }
    return greeting;
  }
}
