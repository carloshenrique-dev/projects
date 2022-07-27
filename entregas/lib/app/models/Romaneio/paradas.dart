import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upentregas/app/models/romaneio/status_parada.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/models/romaneio/romaneio.dart';

class Paradas extends Romaneio {
  // ignore: annotate_overrides, overridden_fields
  int? romId;
  int? codigoParada;
  int? codPedParada;
  String? observacaoInicioParada;
  String? observacaoFimParada;
  String? endereco;
  String? numero;
  String? bairro;
  String? cidade;
  String? uf;
  String? latitude;
  String? longitude;
  Timestamp? dataInicioParada;
  Timestamp? dataConclusaoParada;
  bool? paradaIniciada;
  bool? paradaInicioSincronizado;
  bool? paradaConcluida;
  bool? paradaConclusaoSincronizada;

  Paradas({
    this.romId,
    this.codigoParada,
    this.codPedParada,
    this.observacaoInicioParada,
    this.observacaoFimParada,
    this.endereco,
    this.numero,
    this.bairro,
    this.cidade,
    this.uf,
    this.latitude,
    this.longitude,
    this.dataInicioParada,
    this.dataConclusaoParada,
    this.paradaIniciada,
    this.paradaInicioSincronizado,
    this.paradaConcluida,
    this.paradaConclusaoSincronizada,
  });

  //Construção:
  factory Paradas.fromJson(Map<String, dynamic> parsedJson) {
    return Paradas(
      romId: parsedJson['RomId'],
      codigoParada: parsedJson['codigoParada'],
      codPedParada: parsedJson['codPedParada'],
      observacaoInicioParada: parsedJson['observacaoInicioParada'],
      observacaoFimParada: parsedJson['observacaoFimParada'],
      endereco: parsedJson['endereco'],
      numero: parsedJson['numero'],
      bairro: parsedJson['bairro'],
      cidade: parsedJson['cidade'],
      uf: parsedJson['uf'],
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
      dataInicioParada: parsedJson['dataInicioParada'],
      dataConclusaoParada: parsedJson['dataConclusaoParada'],
      paradaIniciada: parsedJson['paradaIniciada'],
      paradaInicioSincronizado: parsedJson['paradaInicioSincronizado'],
      paradaConcluida: parsedJson['paradaConcluida'],
      paradaConclusaoSincronizada: parsedJson['paradaConclusaoSincronizada'],
    );
  }

  void setSyncInicioParada() {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Paradas')
        .doc(codPedParada.toString())
        .set({
      'paradaInicioSincronizado': true,
    }, SetOptions(merge: true)).then((_) {
      //print('Inicio da parada sincronizado!');
    });
  }

  void setSyncConclusaoParada() {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Paradas')
        .doc(codPedParada.toString())
        .set({
      'paradaConclusaoSincronizada': true,
    }, SetOptions(merge: true)).then((_) {
      //print('Conclusao da parada sincronizada!');
    });
  }

  blockList(int? romId) {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .set({
      'emParada': true,
    }, SetOptions(merge: true)).then((_) {
      //print('Lista bloqueada!');
    });
  }

  unblockList(int? romId) {
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .set({
      'emParada': false,
    }, SetOptions(merge: true)).then((_) {
      //print('Lista desbloqueada!');
    });
  }

  Future<void> startParada(int? romId) async {
    blockList(romId);
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Paradas')
        .doc(codPedParada.toString())
        .set({
      'RomId': romId,
      'codigoParada': codigoParada,
      'codPedParada': codPedParada,
      'paradaIniciada': true,
      'paradaInicioSincronizado': false,
      'paradaConcluida': false,
      'observacaoInicioParada': observacaoInicioParada,
      'tipoParada': 'I',
      'endereco': endereco,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'latitude': latitude,
      'longitude': longitude,
      'dataInicioParada': dataInicioParada,
      'dataConclusaoParada': null,
    }, SetOptions(merge: true)).then((_) {
      //print('Parada iniciada!');
      setSyncInicioParada();
    });
  }

  Future<void> endParada(int? romId) async {
    unblockList(romId);
    content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Paradas')
        .doc(codPedParada.toString())
        .set({
      'codigoParada': codigoParada,
      'codPedParada': codPedParada,
      'paradaConcluida': true,
      'paradaConclusaoSincronizada': false,
      'observacaoFimParada': observacaoFimParada,
      'tipoParada': 'F',
      'endereco': endereco,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'latitude': latitude,
      'longitude': longitude,
      'dataConclusaoParada': dataConclusaoParada,
    }, SetOptions(merge: true)).then((_) {
      //print('Parada finalizada!');
      setSyncConclusaoParada();
    });
  }

  bool isParadaSynchronized() {
    bool paradaConcluida;
    if (this.paradaConcluida != null) {
      paradaConcluida = (this.paradaConcluida)!;
    } else {
      paradaConcluida = false;
    }

    bool paradaSincronizada;

    if (paradaConclusaoSincronizada != null) {
      paradaSincronizada = (paradaConclusaoSincronizada)!;
    } else {
      paradaSincronizada = false;
    }

    final result = (paradaConcluida == paradaSincronizada);

    return result;
  }

  Future<void> envParada() async {
    //print('-> Tentativa de Envio de Sincronização de paradas à API');
    try {
      final retParadaApi = await (envApiInicioParada());
      if (retParadaApi) setSyncInicioParada();
      final retParadaApi1 = await (envApiFimParada());
      if (retParadaApi1) {
        setSyncConclusaoParada();
      }
    } catch (exception) {
      //print(exception.toString());
    }
  }

  Future<bool> envApiFimParada() async {
    StatusConclusaoParada status = getStatusConclusaoParada();
    final statusMap = [status.toMap()];
    final jsonret = await content.api.postList('ParadasUp/Romaneio', statusMap);
    final result = json.decode(jsonret.status.toString());
    //print('Resultado = ${result.toString()}');
    return result;
  }

  Future<bool> envApiInicioParada() async {
    StatusInicioParada status = getStatusInicioParada();
    final statusMap = [status.toMap()];
    final jsonret = await content.api.postList('ParadasUp/Romaneio', statusMap);
    final result = json.decode(jsonret.status.toString());
    //print('Resultado = ${result.toString()}');
    return result;
  }

  StatusInicioParada getStatusInicioParada() {
    final status = StatusInicioParada();
    status.romId = romId;
    status.codigo = codigoParada;
    status.codPedParada = codPedParada;
    status.bairro = bairro;
    status.cidade = cidade;
    status.tipoParada = 'I';
    status.dataInicioParada = dataInicioParada!.toDate();
    status.endereco = endereco;
    status.latitude = latitude;
    status.longitude = longitude;
    status.numero = numero;
    status.observacaoInicioParada = observacaoInicioParada;
    status.uf = uf;
    return status;
  }

  StatusConclusaoParada getStatusConclusaoParada() {
    final status = StatusConclusaoParada();
    status.romId = romId;
    status.codigo = codigoParada;
    status.codPedParada = codPedParada;
    status.bairro = bairro;
    status.tipoParada = 'F';
    status.cidade = cidade;
    status.dataConclusaoParada = dataConclusaoParada!.toDate();
    status.endereco = endereco;
    status.latitude = latitude;
    status.longitude = longitude;
    status.numero = numero;
    status.observacaoFimParada = observacaoFimParada;
    status.uf = uf;
    return status;
  }
}
