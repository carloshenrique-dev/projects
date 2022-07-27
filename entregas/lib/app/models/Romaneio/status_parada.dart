class StatusConclusaoParada {
  int? romId;
  int? codigo;
  int? codPedParada;
  DateTime? dataConclusaoParada;
  String? observacaoFimParada;
  String? tipoParada;
  String? endereco;
  String? numero;
  String? bairro;
  String? cidade;
  String? uf;
  String? latitude;
  String? longitude;

  Map<String, dynamic> toMap() {
    return {
      'RomId': romId,
      'COD_PARADA': codigo,
      'COD_PED_PARADA': codPedParada,
      'OBSERVACAO': observacaoFimParada,
      'TIPO_PARADA': tipoParada,
      'DT_HR_PARADA': dataConclusaoParada != null
          ? dataConclusaoParada!.toIso8601String()
          : null,
      'ENDERECO': endereco,
      'NUMERO': numero,
      'BAIRRO': bairro,
      'CIDADE': cidade,
      'UF': uf,
      'LATITUDE': latitude,
      'LONGITUDE': longitude,
    };
  }
}

class StatusInicioParada {
  int? romId;
  int? codigo;
  int? codPedParada;
  DateTime? dataInicioParada;
  String? observacaoInicioParada;
  String? tipoParada;
  String? endereco;
  String? numero;
  String? bairro;
  String? cidade;
  String? uf;
  String? latitude;
  String? longitude;

  Map<String, dynamic> toMap() {
    return {
      'RomId': romId,
      'COD_PARADA': codigo,
      'COD_PED_PARADA': codPedParada,
      'OBSERVACAO': observacaoInicioParada,
      'TIPO_PARADA': tipoParada,
      'DT_HR_PARADA':
          dataInicioParada != null ? dataInicioParada!.toIso8601String() : null,
      'ENDERECO': endereco,
      'NUMERO': numero,
      'BAIRRO': bairro,
      'CIDADE': cidade,
      'UF': uf,
      'LATITUDE': latitude,
      'LONGITUDE': longitude,
    };
  }
}
