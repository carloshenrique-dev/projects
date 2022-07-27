class StatusReentrega {
  int? romId;
  int? codFil;
  int? codPed;
  String? tipoDocto;
  String? serie;

  Map<String, dynamic> toMap() {
    return {
      'romId': romId,
      'codFil': codFil,
      'codPed': codPed,
      'tipoDocto': tipoDocto,
      'serie': serie,
    };
  }
}

class StatusAtualizacaoEntrega {
  int? romId;
  int? codFil;
  int? codPed;
  int? codOrm;
  String? tipoDocto;
  String? serie;
  bool? rotaEntrega;
  DateTime? dataRotaEntrega;
  bool? entregaConcluida;
  DateTime? dataEntrega;
  String? obsEntrega;
  String? latitude;
  String? longitude;
  bool? statusPgto;
  List? imagens;

  Map<String, dynamic> toMap() {
    return {
      'romId': romId,
      'codFil': codFil,
      'codPed': codPed,
      'codOrm': codOrm,
      'tipoDocto': tipoDocto,
      'serie': serie,
      'entregaConcluida': entregaConcluida ?? false,
      'dataEntrega':
          dataEntrega != null ? dataEntrega!.toIso8601String() : null,
      'rotaEntrega': rotaEntrega ?? false,
      'dataRotaEntrega':
          dataRotaEntrega != null ? dataRotaEntrega!.toIso8601String() : null,
      'imagens': imagens,
      'obsEntrega': obsEntrega,
      'latitude': latitude,
      'longitude': longitude,
      'statusPgto': false,
    };
  }
}

class StatusAtualizacaoRotaEntrega {
  int? romId;
  int? codFil;
  int? codPed;
  String? tipoDocto;
  String? serie;
  bool? rotaEntrega;
  DateTime? dataRotaEntrega;
  String? latitude;
  String? longitude;

  Map<String, dynamic> toMap() {
    return {
      'romId': romId,
      'codFil': codFil,
      'codPed': codPed,
      'tipoDocto': tipoDocto,
      'serie': serie,
      'rotaEntrega': rotaEntrega ?? false,
      'dataRotaEntrega':
          dataRotaEntrega != null ? dataRotaEntrega!.toIso8601String() : null,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
