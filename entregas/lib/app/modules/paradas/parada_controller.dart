import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:upentregas/app/models/romaneio/romaneio.dart';
import 'package:upentregas/app/models/romaneio/paradas.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:upentregas/app/shared/constants/constants.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/shared/controllers/conexao_controller/sem_conexao_controller.dart';
import 'package:upentregas/app/shared/ui/messages/message_provisorio.dart';

class ParadaController extends Romaneio {
  SemConexaoController semConexaoController = SemConexaoController();

  Future<bool> beginParada(
      {String? observacao,
      String? latitude,
      String? longitude,
      required BuildContext context,
      int? romId,
      String? paradaSelecionada}) async {
    bool conexao = await semConexaoController.checkConnectivity();
    var romaneioIniciado = await isRomaneioIniciado(romId);

    if (romaneioIniciado == false) {
      MessageProvisorio().showMessage(message: 'startRomaneio'.tr);
      return false;
    } else {
      try {
        var codigoParada =
            await verificaCodigoParada(paradaSelecionada, context);

        if (conexao) {
          var enderecoCompleto =
              await retornaEndereco(latitude, longitude, context);

          if (enderecoCompleto.isNotEmpty) {
            Paradas paradas = Paradas(
              romId: romId,
              codigoParada: codigoParada,
              codPedParada: await codPedParada(romId),
              endereco: enderecoCompleto[0]!.split(',')[0],
              numero: enderecoCompleto[0]!.split(',')[1],
              bairro: enderecoCompleto[1]!.split(',')[0],
              cidade: enderecoCompleto[1]!.split(',')[1],
              uf: enderecoCompleto[2]!.split(',')[0],
              observacaoInicioParada: observacao,
              dataConclusaoParada: null,
              dataInicioParada: Timestamp.fromDate(DateTime.now()),
              latitude: latitude,
              longitude: longitude,
            );
            await paradas.startParada(romId);
            await paradas.envApiInicioParada();
          }
          return true;
        } else {
          Paradas paradas = Paradas(
            romId: romId,
            codigoParada: codigoParada,
            codPedParada: await codPedParada(romId),
            endereco: 'endereco',
            numero: 'numero',
            bairro: 'bairro',
            cidade: 'cidade',
            uf: 'estado',
            observacaoInicioParada: observacao,
            dataConclusaoParada: null,
            dataInicioParada: Timestamp.fromDate(DateTime.now()),
            latitude: latitude,
            longitude: longitude,
          );
          paradas.startParada(romId);
          return true;
        }
      } catch (e) {
        //print(e);
        return false;
      }
    }
  }

  Future<bool> endParada(
      {String? observacao,
      String? latitude,
      String? longitude,
      required BuildContext context,
      int? romId,
      String? paradaSelecionada}) async {
    bool conexao = await semConexaoController.checkConnectivity();

    try {
      var codigoParada = await verificaCodigoParada(paradaSelecionada, context);

      if (conexao) {
        var enderecoCompleto =
            await retornaEndereco(latitude, longitude, context);
        if (enderecoCompleto.isNotEmpty) {
          Paradas paradas = Paradas(
            romId: romId,
            codigoParada: codigoParada,
            codPedParada: await codPedParada(romId) - 1,
            endereco: enderecoCompleto[0]!.split(',')[0],
            numero: enderecoCompleto[0]!.split(',')[1],
            bairro: enderecoCompleto[1]!.split(',')[0],
            cidade: enderecoCompleto[1]!.split(',')[1],
            uf: enderecoCompleto[2]!.split(',')[0],
            observacaoFimParada: observacao,
            dataConclusaoParada: Timestamp.fromDate(DateTime.now()),
            latitude: latitude,
            longitude: longitude,
          );
          await paradas.endParada(romId);
          await paradas.envApiFimParada();
        }
        return true;
      } else {
        Paradas paradas = Paradas(
          romId: romId,
          codigoParada: codigoParada,
          codPedParada: await codPedParada(romId) - 1,
          endereco: 'endereco',
          numero: 'numero',
          bairro: 'bairro',
          cidade: 'cidade',
          uf: 'estado',
          observacaoFimParada: observacao,
          dataConclusaoParada: Timestamp.fromDate(DateTime.now()),
          latitude: latitude,
          longitude: longitude,
        );
        paradas.endParada(romId);
        return true;
      }
    } catch (e) {
      //print(e);
      return false;
    }
  }

  Future<List<String?>> retornaEndereco(
      String? latitude, String? longitude, BuildContext context) async {
    String formattedAdress;
    List<String> enderecoCompleto = [];

    Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$maps');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        formattedAdress = data['results'][0]['formatted_address'];
        enderecoCompleto = formattedAdress.split('-').toList();
      }
    } catch (e) {
      //print(e);
      MessageProvisorio().showMessage(message: 'verifyConnection'.tr);
    }
    return enderecoCompleto;
  }

  Future<int> verificaCodigoParada(
      String? selectedCurrency, BuildContext context) async {
    int codigo = 0;
    await content.firebaseContent.db!
        .collection('Paradas')
        .doc(selectedCurrency)
        .get()
        .then((data) {
      if (data.data()!.isNotEmpty) {
        codigo = data.data()!['Cod_Parada'];
      } else {
        MessageProvisorio().showMessage(message: 'hasError'.tr);
      }
    });

    return codigo;
  }

  Future<int> codPedParada(int? romId) async {
    int codigoPedParada = 0;

    await content.firebaseContent.db!
        .collection('Romaneios')
        .doc(romId.toString())
        .collection('Paradas')
        .get()
        .then((data) {
      if (data.docs.isNotEmpty) {
        codigoPedParada = int.parse(data.docs.last.id) + 1;
      } else {
        codigoPedParada = 1;
      }
    });
    return codigoPedParada;
  }
}
