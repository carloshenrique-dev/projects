import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:up_template/constants/constants.dart';
import 'package:upentregas/app/models/romaneio/romaneio.dart';
import 'package:upentregas/app/models/romaneio/paradas.dart';
import 'package:upentregas/app/models/item_romaneio/romaneio_itens.dart';
import 'package:upentregas/app/modules/login/login_view.dart';
import 'package:upentregas/app/shared/constants/constants.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/models/romaneio/romaneio_item.dart';
import 'package:upentregas/app/shared/controllers/conexao_controller/sem_conexao_controller.dart';
import 'package:upentregas/app/shared/textcontrollers/textfield_controllers.dart';
import 'package:upentregas/app/shared/ui/messages/message_provisorio.dart';
import 'dart:typed_data';

late Romaneio romaneio;
late Paradas paradas;

String readFileByteByByte(File image) {
  List<int> imageBytes = image.readAsBytesSync();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}

String readUnitList(Uint8List image) {
  String base64Image = base64Encode(image);
  return base64Image;
}

envioImediatoInicioEntrega() async {
  final romaData = await Romaneio.getCurrentRomaneio();
  SemConexaoController semConexaoController = SemConexaoController();
  romaneio = Romaneio.fromJson(romaData);

  bool conexao = await semConexaoController.checkConnectivity();
  if (conexao) {
    try {
      if (romaneio.hasUnsyncrhonizedRota()) {
        await romaneio.envRota();
      }
    } catch (e) {
      //print(e);
    }
  }
}

envioImediatoFimEntrega() async {
  final romaData = await Romaneio.getCurrentRomaneio();
  SemConexaoController semConexaoController = SemConexaoController();
  romaneio = Romaneio.fromJson(romaData);

  bool conexao = await semConexaoController.checkConnectivity();
  if (conexao) {
    try {
      if (romaneio.hasUnsyncrhonizedDeliveries()) {
        await romaneio.envEntregas();
      }
    } catch (e) {
      //
    }
  }
}

envioImediatoInicioRomaneio() async {
  final romaData = await Romaneio.getCurrentRomaneio();
  romaneio = Romaneio.fromJson(romaData);
  if (!romaneio.isRomaneioInicioSynchronized()) {
    await romaneio.setInicioRomaneio();
  }
}

Future<bool?> isRomaneioIniciado(int? romId) async {
  bool? romaneioIniciado;
  await content.firebaseContent.db!
      .collection('Romaneios')
      .doc(romId.toString())
      .get()
      .then((data) async {
    if (data.data()!.containsKey('romaneioIniciado') == false) {
      romaneioIniciado = false;
    } else {
      romaneioIniciado = data['romaneioIniciado'];
    }
  });
  return romaneioIniciado;
}

Future<List<String>> verificaPendencia(int? romId) async {
  List<String> ids = [];
  QuerySnapshot snapshot = await content.firebaseContent.db!
      .collection('Romaneios')
      .doc(romId.toString())
      .collection('Itens')
      .get();
  for (var doc in snapshot.docs) {
    ids.add(
        '${doc['rotaEntrega'].toString()}|${doc['entregaConcluida'].toString()}|${doc['codPed'].toString()}');
  }

  return ids;
}

updateFimEntrega({
  required bool isRota,
  required int? romId,
  required int seq,
  required int? codOrm,
  required String? ocorrencia,
  required String? obsFimEntrega,
  required String? latitude,
  required String? longitude,
}) async {
  RomaneioItem item = RomaneioItem(
    romId: romId,
    seq: seq,
    ocorrencia: ocorrencia,
    codOrm: codOrm,
    obsEntrega: obsFimEntrega,
    dataEntrega: Timestamp.fromDate(DateTime.now()),
    latitude: latitude,
    longitude: longitude,
  );
  await item.finishEntrega();
  await envioImediatoFimEntrega();
  Get.back();
}

Future<void> updateInicioEntrega({
  required int seq,
  required Map<String, dynamic> map,
}) async {
  try {
    RomaneioItem item = RomaneioItem(
      romId: map['romId'],
      seq: seq,
      dataRotaEntrega: map['dataRotaEntrega'],
      latitude: map['latitute'],
      longitude: map['longitude'],
    );
    await item.beginEntrega();
    /*var retorno = await item.apiRotaEntrega(map);
    if (retorno) {
      await rotaEntregaSincronizacao(romId: map['romId'], seq: seq);
    }*/
    await envioImediatoInicioEntrega();
  } catch (e) {
    //
  }
}

Future<bool> updateReaberturaEntrega({
  required bool isRota,
  required int romId,
  required int seq,
  required Map<String, dynamic> map,
}) async {
  try {
    RomaneioItem item = RomaneioItem(
      romId: romId,
      seq: seq,
      dataEntrega:
          Timestamp.fromDate(DateTime.parse('2021-01-01 00:00:00.000')),
      dataRotaEntrega:
          Timestamp.fromDate(DateTime.parse('2021-01-01 00:00:00.000')),
    );
    await item.reaberturaEntrega();
    var retorno = await item.apiReaberturaEntrega(map);
    if (retorno) {
      await reaberturaEntregaSincronizacao(romId: romId, seq: seq);
    }
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> reaberturaEntregaSincronizacao(
    {required int romId, required int seq}) async {
  try {
    await content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Itens')
        .doc(seq.toString())
        .set({'reentregaSincronizada': true}, SetOptions(merge: true));
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> rotaEntregaSincronizacao(
    {required int romId, required int seq}) async {
  try {
    await content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Itens')
        .doc(seq.toString())
        .set({
      'rotaEntregaSincronizada': true,
    }, SetOptions(merge: true)).then((_) {});
    return true;
  } catch (e) {
    return false;
  }
}

verificaStatus(bool? entregaConcluida, bool? rotaEntrega) {
  if (entregaConcluida == false && rotaEntrega == false) {
    return 'pendente';
  } else if (entregaConcluida == false && rotaEntrega == true) {
    return 'em andamento';
  } else if (entregaConcluida == true && rotaEntrega == true) {
    return 'entrega realizada';
  } else if (rotaEntrega == true && entregaConcluida == null) {
    return 'em andamento';
  } else {
    return 'pendente';
  }
}

Stream<List<RomaneioItens>> getItensRomaneio(int id) {
  String docid = id.toString();
  return content.firebaseContent.db!
      .collection('Romaneios')
      .doc(docid)
      .collection('Itens')
      .orderBy('seq', descending: false)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map(
            (document) => RomaneioItens.fromDocumentSnapshot(
              document,
              document.id,
            ),
          )
          .toList());
}

Future<String> getNomeFantasia(String docId) async {
  String empresa = '';
  try {
    await content.firebaseContent.db!
        .collection('Empresa')
        .doc(docId)
        .get()
        .then((data) async {
      if (data.data()!.containsKey('nomeFantasia') == false) {
        return empresa = 'UP';
      } else {
        return empresa = data['nomeFantasia'];
      }
    });
    return empresa;
  } catch (e) {
    //print(e);
    return empresa = 'UP';
  }
}

int convert(String controller) {
  int myInt = int.parse(controller);
  assert(myInt is int);
  return myInt;
}

Future<void> inicioRomaneio(int? id, String kmsaida, String imgOdometro,
    String obs, BuildContext context) async {
  bool? romaneioIniciado = await isRomaneioIniciado(id);
  if (romaneioIniciado == false) {
    roma.romId = id;
    roma.dataIniOperacao = Timestamp.fromDate(DateTime.now());
    roma.kmInicio = convert(kmsaida);
    roma.obsInicioRomaneio = obs;
    roma.imgOdometroInicial = imgOdometro;
    await roma.startRomaneio();
    await firstDocument(id, context);
    envioImediatoInicioRomaneio();
    clearControllerRomaneio();
  } else if (romaneioIniciado == true) {
    MessageProvisorio().showMessage(message: 'romaneioStarted'.tr);
    clearControllerRomaneio();
  } else {
    MessageProvisorio().showMessage(message: 'errorStartRomaneio'.tr);
    clearControllerRomaneio();
  }
}

Future<bool> fimRomaneio(int? id, String kmchegada, String imgOdometroFinal,
    String obs, BuildContext context) async {
  try {
    DocumentSnapshot snapshot = await content.firebaseContent.db!
        .collection('Romaneios')
        .doc(id.toString())
        .get();
    bool? romaneioIniciado = await isRomaneioIniciado(id);
    bool? romaneioConcluido = snapshot['romaneioConcluido'];
    if (romaneioIniciado == null || romaneioIniciado == false) {
      MessageProvisorio().showMessage(message: 'startRomaneio'.tr);
      return false;
    } else if (romaneioIniciado == true &&
        (romaneioConcluido == null || romaneioConcluido == false)) {
      roma.romId = id;
      roma.dataConclusaoOperacao = Timestamp.fromDate(DateTime.now());
      roma.kmTermino = convert(kmchegada);
      roma.obsRetornoRomaneio = obs;
      roma.imgOdometroFinal = imgOdometroFinal;
      roma.qtdEngChegada = 0;
      bool conclusao = await roma.setConclusaoRomaneio();
      if (conclusao) {
        clearControllerRomaneio();
        return true;
      } else {
        return false;
      }
    } else if (romaneioConcluido == true) {
      MessageProvisorio().showMessage(message: 'endRomaneio'.tr);
      clearControllerRomaneio();
      return false;
    } else {
      MessageProvisorio().showMessage(message: 'endRomaneio'.tr);
      return false;
    }
  } catch (e) {
    return false;
  }
}

clearControllerRomaneio() {
  kmController.clear();
  obsRomaneioController.clear();
}

Future firstDocument(int? id, BuildContext context) async {
  await content.firebaseContent.db!
      .collection('Romaneios')
      .doc(id.toString())
      .collection('Itens')
      .get()
      .then(
    (data) {
      var item = data.docs.map((e) {
        return RomaneioItens.fromDocumentSnapshot(e, e.id);
      });
      Get.toNamed(
        '/romaneiodetails',
        parameters: {
          'romaneioId': '$id',
        },
        arguments: item.first,
      );
    },
  );
}

Future<void> signOut() async {
  await firebaseAuth.signOut().catchError((error) {
    //print(error.toString());
  });
  Get.to(() => const LoginView());
}

void saveId(String id) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'clientId';
  final value = id;
  prefs.setString(key, value);
}

Future<String> recId() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'clientId';
  final value = prefs.get(key) ?? '';
  return value as FutureOr<String>;
}
