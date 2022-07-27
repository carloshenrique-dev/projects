import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/models/fim_entrega/ocorrencias_model.dart';
import 'package:upentregas/app/modules/signature/signature_view.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/services/localization_firestore.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/shared/controllers/conexao_controller/sem_conexao_controller.dart';
import 'package:upentregas/app/shared/ui/loader/loader_mixin.dart';
import 'package:upentregas/app/shared/ui/messages/messages_mixin.dart';

class FimEntregaController extends GetxController
    with LoaderMixin, MessagesMixin, LocalizationFirestore {
  final title = ''.obs;
  final romId = 0.obs;
  final idItem = ''.obs;
  final codPed = ''.obs;
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final descOcorrencia = ''.obs;
  final ocoPositiva = false.obs;
  var selectedItem = 'selectOccurrence'.tr.obs;
  final statusOcorrencia = false.obs;
  Uint8List? signature;
  IconData ocorrenciaIcon = Icons.error;
  String? itemSelecionado;
  List<OcorrenciasModel> ocorrencias = <OcorrenciasModel>[].obs;
  final photos = <File>[].obs;
  TextEditingController ocorrenciaController = TextEditingController();
  SemConexaoController semConexaoController = SemConexaoController();

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    retornaParametros();
  }

  @override
  void onReady() {
    super.onReady();
    getOcorrencia();
  }

  void changeSelect(select) {
    selectedItem.value = select;
  }

  @override
  void onClose() {
    rawImage.value = null;
  }

  retornaParametros() {
    title.value = Get.parameters['title'] ?? 'UpSoftware';
    romId.value = int.parse(Get.parameters['romId']!);
    idItem.value = Get.parameters['idItem']!;
    codPed.value = Get.parameters['codPed']!;
  }

  Future<bool> multiplasImagens(
      {String? idItem,
      int? docId,
      String? codPed,
      required String assinatura}) async {
    bool hasConnection = await semConexaoController.checkConnectivity();
    try {
      var id = await recId();

      if (hasConnection) {
        if (photos != []) {
          for (int i = 0; i < photos.length; i++) {
            var base64Image = readFileByteByByte(photos[i]);
            await content.envioS3(
                base64: base64Image,
                nomeArquivo: 'Entrega_$codPed-${i + 1}',
                path: '/$id/$docId');
          }
        }
        await content.envioS3(
            base64: assinatura,
            nomeArquivo: 'Assinatura_$codPed',
            path: '/$id/$docId');
        return true;
      } else {
        var list = [];
        var listAssinatura = [];
        if (photos != [] && assinatura != '') {
          for (int i = 0; i < photos.length; i++) {
            var base64Image = readFileByteByByte(photos[i]);
            list.add({
              'nomeArquivo': 'Entrega_$codPed-${i + 1}',
              'imagem': base64Image,
            });
          }
          listAssinatura
              .add({'nomeArquivo': 'Assinatura_$codPed', 'imagem': assinatura});
        }
        await saveImagesFirestore(docId, idItem, list, listAssinatura);
      }
      return true;
    } catch (e) {
      //print(e);
      return false;
    }
  }

  sendSignature({required String assinatura}) async {
    bool hasConnection = await semConexaoController.checkConnectivity();
    try {
      var id = await recId();

      if (hasConnection) {
        await content.envioS3(
            base64: assinatura,
            nomeArquivo: 'Assinatura_$codPed',
            path: '/$id/${idItem.value}');
        return true;
      } else {
        var listAssinatura = [];
        if (assinatura != '') {
          listAssinatura
              .add({'nomeArquivo': 'Assinatura_$codPed', 'imagem': assinatura});
        }
        await saveSignatureFirestore(romId.value, idItem.value, listAssinatura);
      }
      return true;
    } catch (e) {
      //print(e);
      return false;
    }
  }

  Future<void> saveImagesFirestore(int? docId, String? idItem,
      List<dynamic> imagens, List<dynamic> assinatura) async {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(docId.toString())
        .collection('Itens')
        .doc(idItem)
        .set({'imagens': imagens}, SetOptions(merge: true)).then((_) {
      //print('Imagens Salvas!');
    });

    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(docId.toString())
        .collection('Itens')
        .doc(idItem)
        .set({'assinatura': assinatura}, SetOptions(merge: true)).then((_) {
      //print('Assinatura Salva!');
    });
  }

  Future<void> saveSignatureFirestore(
      int? docId, String? idItem, List<dynamic> assinatura) async {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(docId.toString())
        .collection('Itens')
        .doc(idItem)
        .set({'assinatura': assinatura}, SetOptions(merge: true));
  }

  Future<bool> envioImagens() async {
    String assinatura = '';
    try {
      if (signature != null && signature != []) {
        assinatura = readUnitList(signature!);
      }
      bool isImageSent = await multiplasImagens(
          idItem: idItem.value,
          docId: romId.value,
          codPed: codPed.value,
          assinatura: assinatura);
      return isImageSent;
    } catch (e) {
      //print(e);
      return false;
    }
  }

  alteraIconeOcorrencia(String id) {
    if (ocorrencias.isNotEmpty) {
      for (var ocorrencia in ocorrencias) {
        if (ocorrencia.id == id) {
          if (ocorrencia.ocoPositiva!) {
            ocorrenciaIcon = Icons.check_circle;
            ocoPositiva.value = ocorrencia.ocoPositiva!;
          } else {
            ocorrenciaIcon = Icons.error;
            ocoPositiva.value = ocorrencia.ocoPositiva!;
          }
        }
      }
    }
  }

  getOcorrencia() async {
    await content.firebaseContent.db!
        .collection('Ocorrências')
        .get()
        .then((value) {
      for (var element in value.docs) {
        ocorrencias.add(OcorrenciasModel.fromDocumentSnapshot(element));
      }
    });
  }

  Future sendData(BuildContext context) async {
    loading(true);
    try {
      if (itemSelecionado != null) {
        var location = await Geolocator.getCurrentPosition();
        int item = int.parse(idItem.value);
        int? codigoOcorrencia = int.tryParse(selectedItem.value);

        if (signature == null || signature == []) {
          loading(false);
          message(MessageModel.error(message: 'requiredSignature'.tr));
        } else if (photos.isEmpty) {
          String assinatura = '';
          if (signature != null && signature != []) {
            assinatura = readUnitList(signature!);
          }
          await sendSignature(assinatura: assinatura);
          await updateLocalizacaoEntrega(
            romId: romId.value,
            item: item,
            latitude: location.latitude.toString(),
            longitude: location.longitude.toString(),
          );
          await updateFimEntrega(
            isRota: false,
            romId: romId.value,
            seq: item,
            codOrm: codigoOcorrencia,
            ocorrencia: descOcorrencia.value,
            obsFimEntrega: ocorrenciaController.text,
            latitude: location.latitude.toString(),
            longitude: location.longitude.toString(),
          );
          loading(false);
        } else {
          await envioImagens();
          //if (isSent) {
          await updateLocalizacaoEntrega(
              romId: romId.value,
              item: item,
              latitude: location.latitude.toString(),
              longitude: location.longitude.toString());
          await updateFimEntrega(
            isRota: false,
            romId: romId.value,
            seq: item,
            codOrm: codigoOcorrencia,
            ocorrencia: descOcorrencia.value,
            obsFimEntrega: ocorrenciaController.text,
            latitude: location.latitude.toString(),
            longitude: location.longitude.toString(),
          );
          loading(false);
          /*} else {
            loading(false);
          }*/
        }
      } else {
        loading(false);
        message(MessageModel.error(message: 'selectOccurrence'.tr));
      }
    } on Exception {
      loading(false);
      message(MessageModel.error(message: 'hasError'.tr));
    }
  }
}
