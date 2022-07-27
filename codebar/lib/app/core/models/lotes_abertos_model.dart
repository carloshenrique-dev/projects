import 'dart:convert';

class LotesAbertosModel {
  final int? codLote;
  final String? itndes;
  final String? data;
  final int? qtdPedidos;
  final String? veiculo;
  final String? statusLote;

  LotesAbertosModel({
    this.codLote,
    this.itndes,
    this.data,
    this.qtdPedidos,
    this.veiculo,
    this.statusLote,
  });

  LotesAbertosModel copyWith({
    int? codLote,
    String? itndes,
    String? data,
    int? qtdPedidos,
    String? veiculo,
    String? statusLote,
  }) {
    return LotesAbertosModel(
      codLote: codLote ?? this.codLote,
      itndes: itndes ?? this.itndes,
      data: data ?? this.data,
      qtdPedidos: qtdPedidos ?? this.qtdPedidos,
      veiculo: veiculo ?? this.veiculo,
      statusLote: statusLote ?? this.statusLote,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codLote': codLote,
      'itndes': itndes,
      'data': data,
      'qtdPedidos': qtdPedidos,
      'veiculo': veiculo,
      'statusLote': statusLote,
    };
  }

  factory LotesAbertosModel.fromMap(Map<String, dynamic> map) {
    return LotesAbertosModel(
      codLote: map['codLote'],
      itndes: map['itndes'],
      data: map['data'],
      qtdPedidos: map['qtdPedidos'],
      veiculo: map['veiculo'],
      statusLote: map['statusLote'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LotesAbertosModel.fromJson(Map<String, dynamic> json) {
    return LotesAbertosModel(
      codLote: json['cod_lote'],
      data: json['data'],
      itndes: json['itndes'],
      qtdPedidos: json['qtd_pedidos'],
      statusLote: json['status_lote'],
      veiculo: json['veiculo'],
    );
  }

  @override
  String toString() {
    return 'LotesAbertosModel(codLote: $codLote, itndes: $itndes, data: $data, qtdPedidos: $qtdPedidos, veiculo: $veiculo, statusLote: $statusLote)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LotesAbertosModel &&
        other.codLote == codLote &&
        other.itndes == itndes &&
        other.data == data &&
        other.qtdPedidos == qtdPedidos &&
        other.veiculo == veiculo &&
        other.statusLote == statusLote;
  }

  @override
  int get hashCode {
    return codLote.hashCode ^
        itndes.hashCode ^
        data.hashCode ^
        qtdPedidos.hashCode ^
        veiculo.hashCode ^
        statusLote.hashCode;
  }
}
