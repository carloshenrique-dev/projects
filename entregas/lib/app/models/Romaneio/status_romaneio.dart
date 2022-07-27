class StatusConclusaoRomaneio {
  int? romId;
  DateTime? dataConclusaoOperacao;
  int? kmTermino;
  String? imgOdometroFinal;
  int? qtdEngChegada;
  String? obsRetornoRomaneio;

  Map<String, dynamic> toMap() {
    return {
      'romId': romId,
      'dtConclusaoOperacao': dataConclusaoOperacao?.toIso8601String(),
      'kmTermino': kmTermino,
      'imgOdometroFinal': imgOdometroFinal,
      'qtdEngChegada': 0,
      'obsRetornoRomaneio': obsRetornoRomaneio,
    };
  }
}

class StatusInicioRomaneio {
  int? romId;
  DateTime? dataIniOperacao;
  int? kmInicio;
  String? imgOdometroInicial;
  String? obsInicioRomaneio;

  Map<String, dynamic> toMap() {
    return {
      'romId': romId,
      'dtIniOperacao': dataIniOperacao?.toIso8601String(),
      'kmInicio': kmInicio,
      'imgOdometroInicial': imgOdometroInicial,
      'obsInicioRomaneio': obsInicioRomaneio
    };
  }
}
