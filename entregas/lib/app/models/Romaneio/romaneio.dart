import 'dart:convert';
import 'dart:isolate';
import 'package:upentregas/app/models/content/isolate_romaneio_update.dart';
import 'package:upentregas/app/models/romaneio/motorista.dart';
import 'package:upentregas/app/models/romaneio/paradas.dart';
import 'package:upentregas/app/models/romaneio/romaneio_item.dart';
import 'package:upentregas/app/models/romaneio/status_romaneio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/shared/constants/variables.dart';

class Romaneio {
  int? romId;
  Timestamp? dataIniOperacao;
  bool? romaneioIniciado;
  bool? romaneioInicioSincronizado;
  Timestamp? dataConclusaoOperacao;
  bool? romaneioConcluido;
  bool? romaneioConclusaoSincronizada;
  int? kmInicio;
  int? kmTermino;
  int? qtdEngChegada;
  String? imgOdometroInicial;
  String? imgOdometroFinal;
  String? obsInicioRomaneio;
  String? obsRetornoRomaneio;
  List<RomaneioItem>? romaneioItens;
  List<Paradas>? paradas;
  Motorista? motorista;

  Romaneio({
    this.romId,
    this.dataIniOperacao,
    this.romaneioIniciado = false,
    this.romaneioInicioSincronizado = false,
    this.dataConclusaoOperacao,
    this.romaneioConcluido = false,
    this.romaneioConclusaoSincronizada = false,
    this.kmInicio,
    this.kmTermino,
    this.qtdEngChegada,
    this.imgOdometroInicial,
    this.imgOdometroFinal,
    this.obsInicioRomaneio,
    this.obsRetornoRomaneio,
    this.romaneioItens,
    this.motorista,
    this.paradas,
  });

  //Construção:
  factory Romaneio.fromJson(Map<String, dynamic> parsedJson) {
    return Romaneio(
      romId: int.parse(parsedJson['romId']),
      dataIniOperacao: parsedJson['dataIniOperacao'],
      romaneioIniciado: parsedJson['romaneioIniciado'],
      romaneioInicioSincronizado: parsedJson['romaneioInicioSincronizado'],
      dataConclusaoOperacao: parsedJson['dataConclusaoOperacao'],
      romaneioConcluido: parsedJson['romaneioConcluido'],
      romaneioConclusaoSincronizada:
          parsedJson['romaneioConclusaoSincronizada'],
      kmInicio: parsedJson['kmInicio'],
      kmTermino: parsedJson['kmTermino'],
      qtdEngChegada: parsedJson['qtdEngChegada'],
      imgOdometroInicial: parsedJson['imgOdometroInicial'],
      imgOdometroFinal: parsedJson['imgOdometroFinal'],
      obsInicioRomaneio: parsedJson['obsInicioRomaneio'],
      obsRetornoRomaneio: parsedJson['obsRetornoRomaneio'],
      romaneioItens: parsedJson['itens'],
      paradas: parsedJson['paradas'],
      //motorista: parsedJson['motorista'],
    );
  }

  static Future<Map<String, dynamic>> getCurrentRomaneio() async {
    String id = idGeral.toString();
    return await content.firebaseContent.db!
        .collection('Romaneios')
        .doc(id)
        .get()
        .then((event) async {
      Map<String, dynamic> documentData = event.data()!;
      final itens = await getRomaneioItens();
      final paradas = await getParadas();
      documentData.addAll({'romId': id, 'itens': itens, 'paradas': paradas});
      return documentData;
    });
  }

  static Future<List<RomaneioItem>> getRomaneioItens() async {
    List<RomaneioItem> itenList = <RomaneioItem>[];
    String? id = idGeral.toString();

    await content.firebaseContent.db!
        .collection('Romaneios')
        .doc(id)
        .collection('Itens')
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        List<QueryDocumentSnapshot> documentData = event.docs.toList();
        for (var element in documentData) {
          Map<String, dynamic> elementData =
              element.data() as Map<String, dynamic>;
          elementData.addAll({
            'seq': element.id,
            'romId': id,
          });

          RomaneioItem item = RomaneioItem.fromJson(elementData);
          itenList.add(item);
        }
      }
    });

    return itenList;
  }

  static Future<List<Paradas>> getParadas() async {
    List<Paradas> paradas = <Paradas>[];
    String? id = idGeral.toString();

    await content.firebaseContent.db!
        .collection('Romaneios')
        .doc(id)
        .collection('Paradas')
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        List<QueryDocumentSnapshot> documentData = event.docs.toList();
        for (var element in documentData) {
          Map<String, dynamic> elementData =
              element.data() as Map<String, dynamic>;

          Paradas parada = Paradas.fromJson(elementData);
          paradas.add(parada);
        }
      }
    });

    return paradas;
  }

  //Validação:
  bool isRomaneioInicioSynchronized() {
    bool result = false;
    bool? romaneioIniciado;
    if (this.romaneioIniciado != null) {
      romaneioIniciado = (this.romaneioIniciado);
    } else {
      romaneioIniciado = false;
    }

    bool? romaneioSincronizado;
    if (romaneioInicioSincronizado != null) {
      romaneioSincronizado = (romaneioInicioSincronizado);
    } else {
      romaneioSincronizado = false;
    }

    if (romaneioIniciado == true && romaneioSincronizado == true) {
      //print('1: Verificação do Início do Romaneio: Sincronizado = True');
      result = true;
    } else if (romaneioConcluido == true &&
        (romaneioConclusaoSincronizada == false ||
            romaneioConclusaoSincronizada == null)) {
      //print("1: Verificação do Início do Romaneio: Sincronizado = False");
      result = false;
    }
    return result;
  }

  bool isRomaneioConclusaoSynchronized() {
    bool result = false;
    bool? romaneioConcluido;
    if (this.romaneioConcluido != null) {
      romaneioConcluido = (this.romaneioConcluido);
    } else {
      romaneioConcluido = false;
    }

    bool? romaneioConclusaoSincronizada;
    if (this.romaneioConclusaoSincronizada != null) {
      romaneioConclusaoSincronizada = (this.romaneioConclusaoSincronizada);
    } else {
      romaneioConclusaoSincronizada = false;
    }

    if (romaneioConcluido == true && romaneioConclusaoSincronizada == true) {
      //print("1: Verificação do fim do Romaneio: Sincronizado = True");
      killIsolate();
      result = true;
    } else if (romaneioConcluido == true &&
        (romaneioConclusaoSincronizada == false ||
            romaneioConclusaoSincronizada == null)) {
      //print("1: Verificação do fim do Romaneio: Sincronizado = False");
      result = false;
    }
    return result;
  }

  //Conversão:
  StatusInicioRomaneio getStatusInicio() {
    final status = StatusInicioRomaneio();
    status.romId = romId;
    status.dataIniOperacao = dataIniOperacao!.toDate();
    status.kmInicio = kmInicio;
    status.imgOdometroInicial = imgOdometroInicial;
    status.obsInicioRomaneio = obsInicioRomaneio;
    return status;
  }

  StatusConclusaoRomaneio getStatusConclusao() {
    final status = StatusConclusaoRomaneio();
    status.romId = romId;
    status.dataConclusaoOperacao = dataConclusaoOperacao?.toDate();
    status.qtdEngChegada = qtdEngChegada;
    status.kmTermino = kmTermino;
    status.imgOdometroFinal = imgOdometroFinal;
    status.obsRetornoRomaneio = obsRetornoRomaneio;
    return status;
  }

  //Sincronização:
  //Base
  Future<void> setInicioRomaneio() async {
    try {
      var id = await recId();
      final retEnv = await (envAPIInicioRomaneio());
      if (retEnv) setSyncInicioRomaneio();
      await content.envioS3(
          base64: imgOdometroInicial,
          nomeArquivo: 'Odometro_Saida',
          path: '/$id/$romId');
    } catch (exception) {
      //print(exception.toString());
    }
  }

  Future<bool> setConclusaoRomaneio() async {
    try {
      var id = await recId();
      await finishRomaneio();
      final retEnv = await envAPIConclusaoRomaneio();
      if (retEnv) {
        setSyncConclusaoRomaneio();
        await content.envioS3(
            base64: imgOdometroFinal,
            nomeArquivo: 'Odometro_Chegada',
            path: '/$id/$romId');
        return true;
      } else {
        return false;
      }
    } catch (exception) {
      //print(exception.toString());
      return false;
    }
  }

  void setSyncInicioRomaneio() {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .set({
      'romaneioInicioSincronizado': true,
    }, SetOptions(merge: true)).then((_) {
      //print('Status atualizado no Firestore.');
    });
  }

  void setSyncConclusaoRomaneio() {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .set({
      'romaneioAberto': false,
      'romaneioConclusaoSincronizada': true,
    }, SetOptions(merge: true)).then((_) {
      //print('Status atualizado no Firestore.');
    });
  }

  //Operação:
  Future<void> startRomaneio() async {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .set({
      'romaneioIniciado': true,
      'romaneioInicioSincronizado': false,
      'romaneioConcluido': false,
      'romaneioConclusaoSincronizada': false,
      'dataIniOperacao': dataIniOperacao,
      'dataConclusaoOperacao': null,
      'kmInicio': kmInicio,
      'emParada': false,
      'imgOdometroInicial': imgOdometroInicial,
      'obsInicioRomaneio': obsInicioRomaneio,
    }, SetOptions(merge: true)).then((_) {
      //print('Firestore: Romaneio $romId Iniciado!');
    });
    update = IsolateRomaneioUpdate();
  }

  Future<void> finishRomaneio() async {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .set({
      'romaneioConcluido': true,
      'dataConclusaoOperacao': dataConclusaoOperacao,
      'kmTermino': kmTermino,
      'emParada': false,
      'imgOdometroFinal': imgOdometroFinal,
      'obsRetornoRomaneio': obsRetornoRomaneio,
      'qtdEngChegada': 0,
    }, SetOptions(merge: true)).then((_) {
      //print('Firestore: Romaneio $romId Concluído!');
    });
  }

  bool hasUnsyncrhonizedDeliveries() {
    final result = romaneioItens!
        .where(
            (element) => (element.isEntregaRealizacaoSynchronized() == false))
        .isNotEmpty;
    //print(
    //    "3: Envio entrega do Romaneio. => Itens sincronizados = ${(!result).toString()} ");

    return result;
  }

  bool hasUnsyncrhonizedRota() {
    final result = romaneioItens!
        .where((element) => (element.isRotaEntregaSynchronized() == false))
        .isNotEmpty;
    //print(
    //    "3: Envio entrega do Romaneio. => Itens sincronizados = ${(!result).toString()} ");

    return result;
  }

  bool hasUnsyncrhonizedParadas() {
    final result = paradas!
        .where((element) => (element.isParadaSynchronized() == false))
        .isNotEmpty;
    //print(
    //    "2: Envio da parada do Romaneio. => Itens sincronizados = ${(!result).toString()} ");

    return result;
  }

  //Itens
  Future<void> envEntregas() async {
    romaneioItens!
        .removeWhere((item) => item.isEntregaRealizacaoSynchronized());
    for (var element in romaneioItens!) {
      //print("-> Envio da Entrega ${element.seq}");
      await element.envEntrega();
    }
  }

  //Itens
  Future<void> envRota() async {
    romaneioItens!.removeWhere((item) => item.isRotaEntregaSynchronized());
    for (var element in romaneioItens!) {
      //print("-> Envio da Entrega ${element.seq}");
      await element.envRota();
    }
  }

  //Itens
  Future<void> envParadas() async {
    paradas!.removeWhere((item) => item.isParadaSynchronized());
    for (var element in paradas!) {
      //print("-> Envio da parada de codigo ${element.codPedParada}");
      await element.envParada();
    }
  }

  void killIsolate() {
    Isolate? isolate;

    if (isolate != null) {
      //print("Stopping isolate");
      isolate.kill();
      isolate = null;
    }
  }

  Future<bool> envAPIInicioRomaneio() async {
    StatusInicioRomaneio status = getStatusInicio();
    final mapStatus = status.toMap();

    final jsonret = await content.api
        .putGeneric('RomaneioUp/putStatusInicioRomaneio', mapStatus);
    final result = json.decode(jsonret.response!)['retStatus'];
    //print('Tentativa de envio à API. => Resultado = ${result.toString()}');
    return result;
  }

  Future<bool> envAPIConclusaoRomaneio() async {
    StatusConclusaoRomaneio status = getStatusConclusao();
    final mapStatus = status.toMap();

    final jsonret = await content.api
        .putGeneric('RomaneioUp/putStatusConclusaoRomaneio', mapStatus);
    final result = json.decode(jsonret.response!)['retStatus'];
    //print("Tentativa de envio à API. => Resultado = ${result.toString()}");
    return result;
  }
}
