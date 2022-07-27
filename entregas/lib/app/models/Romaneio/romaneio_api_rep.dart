import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/models/romaneio/romaneio.dart';
import 'dart:convert';

extension API on Romaneio {
  //API
  Future<bool> envAPIInicioRomaneio() async {
    var status = getStatusInicio();
    final mapStatus = status.toMap();

    final jsonret = await content.api
        .putGeneric('RomaneioUp/putStatusInicioRomaneio', mapStatus);
    final result = json.decode(jsonret.response!)['retStatus'];
    //print('Tentativa de envio à API. => Resultado = ${result.toString()}');
    return result;
  }

  Future<bool> envAPIConclusaoRomaneio() async {
    var status = getStatusConclusao();
    final mapStatus = status.toMap();

    final jsonret = await content.api
        .putGeneric('RomaneioUp/putStatusConclusaoRomaneio', mapStatus);
    final result = json.decode(jsonret.response!)['retStatus'];
    //print("Tentativa de envio à API. => Resultado = ${result.toString()}");
    return result;
  }
}
