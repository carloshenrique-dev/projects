import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'status_romaneio_item.dart';

class RomaneioItem {
  int? romId;
  int? codFil;
  int? codPed;
  int? codOrm;
  String? tipo;
  String? ocorrencia;
  int? seq;
  String? tipoDocto;
  String? serie;
  bool? rotaEntrega;
  Timestamp? dataRotaEntrega;
  bool? rotaEntregaSincronizada;
  bool? entregaConcluida;
  bool? entregaConclusaoSincronizado;
  Timestamp? dataEntrega;
  String? urlImgAssinatura;
  String? urlImgEntrega;
  String? obsEntrega;
  String? latitude;
  String? longitude;
  bool? statusPgto;

  RomaneioItem({
    this.romId,
    this.codFil,
    this.codPed,
    this.codOrm,
    this.tipo,
    this.seq,
    this.tipoDocto,
    this.serie,
    this.rotaEntrega,
    this.dataRotaEntrega,
    this.rotaEntregaSincronizada,
    this.entregaConcluida,
    this.entregaConclusaoSincronizado,
    this.dataEntrega,
    this.urlImgAssinatura,
    this.urlImgEntrega,
    this.obsEntrega,
    this.latitude,
    this.longitude,
    this.statusPgto,
    this.ocorrencia,
  });

  factory RomaneioItem.fromJson(Map<String, dynamic> parsedJson) {
    return RomaneioItem(
      romId: int.parse(parsedJson['romId']),
      codFil: parsedJson['codFil'],
      codPed: parsedJson['codPed'],
      codOrm: parsedJson['codOrm'],
      tipo: parsedJson['tipo'],
      seq: int.parse(parsedJson['seq']),
      tipoDocto: parsedJson['tipoDocto'],
      serie: parsedJson['serie'],
      rotaEntrega: parsedJson['rotaEntrega'],
      dataRotaEntrega: parsedJson['dataRotaEntrega'],
      rotaEntregaSincronizada: parsedJson['rotaEntregaSincronizada'],
      entregaConcluida: parsedJson['entregaConcluida'],
      entregaConclusaoSincronizado: parsedJson['entregaConclusaoSincronizado'],
      dataEntrega: parsedJson['dataEntrega'],
      urlImgAssinatura: parsedJson['urlImgAssinatura'],
      urlImgEntrega: parsedJson['urlImgEntrega'],
      obsEntrega: parsedJson['obsEntrega'],
      ocorrencia: parsedJson['ocorrencia'],
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
      statusPgto: parsedJson['statusPgto'],
    );
  }

  Future<void> finishEntrega() async {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Itens')
        .doc(seq.toString())
        .set({
      'entregaConcluida': true,
      'entregaConclusaoSincronizado': false,
      'dataEntrega': dataEntrega,
      'urlImgAssinatura': 'Nao Implementado',
      'urlImgEntrega': 'Nao Implementado',
      'ocorrencia': ocorrencia,
      'codOrm': codOrm,
      'obsEntrega': obsEntrega,
      'latitude': latitude,
      'longitude': longitude,
      'statusPgto': false,
    }, SetOptions(merge: true)).then((_) {});
  }

  Future<void> beginEntrega() async {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Itens')
        .doc(seq.toString())
        .set({
      'rotaEntrega': true,
      'rotaEntregaSincronizada': false,
      'dataRotaEntrega': dataRotaEntrega,
      'latitude': latitude,
      'longitude': longitude,
    }, SetOptions(merge: true)).then((_) {});
  }

  Future<bool> reaberturaEntrega() async {
    try {
      content.firebaseContent.db!
          .collection('Romaneios')
          .doc(romId.toString())
          .collection('Itens')
          .doc(seq.toString())
          .set({
        'rotaEntrega': false,
        'rotaEntregaSincronizada': false,
        'dataRotaEntrega': dataRotaEntrega,
        'entregaConcluida': false,
        'entregaConclusaoSincronizado': false,
        'dataEntrega': dataEntrega,
        'urlImgAssinatura': 'Nao Implementado',
        'urlImgEntrega': 'Nao Implementado',
        'ocorrencia': '',
        'codOrm': 0,
        'obsEntrega': '',
        'latitude': latitude,
        'longitude': longitude,
        'statusPgto': false,
        'reentregaSincronizada': false
      }, SetOptions(merge: true));
      return false;
    } catch (e) {
      return false;
    }
  }

  bool isEntregaRealizacaoSynchronized() {
    bool entregaConcluida;
    if (this.entregaConcluida != null) {
      entregaConcluida = (this.entregaConcluida)!;
    } else {
      entregaConcluida = false;
    }

    bool entregaSincronizada;

    if (entregaConclusaoSincronizado != null) {
      entregaSincronizada = (entregaConclusaoSincronizado)!;
    } else {
      entregaSincronizada = false;
    }

    final result = (entregaConcluida == entregaSincronizada);

    return result;
  }

  bool isRotaEntregaSynchronized() {
    bool rotaEntrega;
    if (this.rotaEntrega != null) {
      rotaEntrega = (this.rotaEntrega)!;
    } else {
      rotaEntrega = false;
    }

    bool rotaEntregaSincronizada;

    if (this.rotaEntregaSincronizada != null) {
      rotaEntregaSincronizada = (this.rotaEntregaSincronizada)!;
    } else {
      rotaEntregaSincronizada = false;
    }

    final result = (rotaEntrega == rotaEntregaSincronizada);

    return result;
  }

  StatusAtualizacaoEntrega getStatusAtualizacao() {
    final status = StatusAtualizacaoEntrega();
    status.romId = romId;
    status.codFil = codFil;
    status.codPed = codPed;
    status.codOrm = codOrm;
    status.tipoDocto = tipoDocto;
    status.serie = serie;
    status.dataEntrega = dataEntrega != null ? dataEntrega!.toDate() : null;
    status.dataRotaEntrega =
        dataRotaEntrega != null ? dataRotaEntrega!.toDate() : null;
    status.entregaConcluida = entregaConcluida;
    status.obsEntrega = obsEntrega;
    status.latitude = latitude;
    status.longitude = longitude;
    status.rotaEntrega = rotaEntrega;
    status.statusPgto = statusPgto;
    return status;
  }

  StatusAtualizacaoRotaEntrega getStatusAtualizacaoRota() {
    final status = StatusAtualizacaoRotaEntrega();
    status.romId = romId;
    status.codFil = codFil;
    status.codPed = codPed;
    status.tipoDocto = tipoDocto;
    status.serie = serie;
    status.rotaEntrega = rotaEntrega;
    status.dataRotaEntrega =
        dataRotaEntrega != null ? dataRotaEntrega!.toDate() : null;
    status.latitude = latitude;
    status.longitude = longitude;
    return status;
  }

  StatusReentrega getStatusReentrega() {
    final status = StatusReentrega();
    status.romId = romId;
    status.codFil = codFil;
    status.codPed = codPed;
    status.tipoDocto = tipoDocto;
    status.serie = serie;
    return status;
  }

  Future<void> envEntrega() async {
    try {
      bool retReaberturaEntrega = await envReaberturaEntrega();
      if (retReaberturaEntrega) {
        _setSyncReentrega();
      }
      bool retEnvioImagens = await _envApiImagens();
      if (retEnvioImagens) {
        _setSyncEnvImagens();
      }
      bool retRotaEntregaApi = await (envAPIRotaEntrega());
      if (retRotaEntregaApi) {
        _setSyncRotaEntrega();
      }
      bool retApi = await (envAPIEntrega());
      if (retApi) {
        _setSyncEntrega();
      }
    } catch (exception) {
      //print(exception.toString());
    }
  }

  Future<void> envRota() async {
    try {
      final retRotaEntregaApi = await (envAPIRotaEntrega());
      if (retRotaEntregaApi) _setSyncRotaEntrega();
    } catch (exception) {
      //print(exception.toString());
    }
  }

  void _setSyncEnvImagens() {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Itens')
        .doc(seq.toString())
        .set(
            {'envioImagensSincronizado': true},
            SetOptions(
              merge: true,
            )).then((_) {});
  }

  void _setSyncEntrega() {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Itens')
        .doc(seq.toString())
        .set({
      'entregaConclusaoSincronizado': true,
    }, SetOptions(merge: true)).then((_) {});
  }

  void _setSyncRotaEntrega() {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Itens')
        .doc(seq.toString())
        .set({
      'rotaEntregaSincronizada': true,
    }, SetOptions(merge: true)).then((_) {});
  }

  void _setSyncReentrega() {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Itens')
        .doc(seq.toString())
        .set({
      'reentregaSincronizada': true,
    }, SetOptions(merge: true));
  }

  //API
  Future<bool> envAPIEntrega() async {
    StatusAtualizacaoEntrega status = getStatusAtualizacao();
    final statusMap = status.toMap();
    final jsonret = await content.api
        .putGeneric('RomaneioUp/putStatusConclusaoEntrega', statusMap);
    final result = json.decode(jsonret.response!)['retStatus'];
    return result;
  }

  Future<bool> envAPIRotaEntrega() async {
    StatusAtualizacaoRotaEntrega status = getStatusAtualizacaoRota();
    final statusMap = status.toMap();
    final jsonret = await content.api
        .putGeneric('RomaneioUp/putStatusRotaEntrega', statusMap);
    final result = json.decode(jsonret.response!)['retStatus'];
    return result;
  }

  Future<bool> apiReaberturaEntrega(Map<String, dynamic> map) async {
    final jsonret =
        await content.api.putGeneric('RomaneioUp/putReaberturaEntrega', map);
    final result = json.decode(jsonret.response!)['retStatus'];
    return result;
  }

  Future<bool> apiRotaEntrega(Map<String, dynamic> map) async {
    final jsonret =
        await content.api.putGeneric('RomaneioUp/putStatusRotaEntrega', map);
    return json.decode(jsonret.response!)['retStatus'];
  }

  Future<bool> envReaberturaEntrega() async {
    StatusReentrega status = getStatusReentrega();
    final statusMap = status.toMap();
    final jsonret = await content.api
        .putGeneric('RomaneioUp/putReaberturaEntrega', statusMap);
    final result = json.decode(jsonret.response!)['retStatus'];
    return result;
  }

  Future<bool> _envApiImagens() async {
    bool retorno = false;
    try {
      await content.firebaseContent.db!
          .collection('Romaneios')
          .doc(romaneio.romId.toString())
          .collection('Itens')
          .doc(seq.toString())
          .get()
          .then((value) async {
        if (value.exists &&
            value.data()!.containsKey('imagens') &&
            value.data()!['imagens'] is List &&
            value.data()!['assinatura']) {
          try {
            var id = await recId();
            List lista = value.data()!['imagens'];
            List assinatura = value.data()!['assinatura'];
            for (var i = 0; i < lista.length; i++) {
              await content.envioS3(
                  base64: lista[i]['imagem'],
                  nomeArquivo: lista[i]['nomeArquivo'],
                  path: '/$id/${romaneio.romId}');
            }
            await content.envioS3(
                base64: assinatura[0]['imagem'],
                nomeArquivo: assinatura[0]['nomeArquivo'],
                path: '/$id/${romaneio.romId}');
            retorno = true;
          } catch (e) {
            retorno = false;
          }
        }
      });
    } catch (e) {
      retorno = false;
    }

    return retorno;
  }
}
