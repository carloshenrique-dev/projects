import 'dart:convert';

class ItensPedidoModel {
  final String? codProd;
  final String? descricao;
  final String? procodbar;
  final String? procodbarpe;
  final String? fatObrgmultundsaux;
  final double? qtd;
  final double? qtdConfFat;
  final int? item;
  final double? qtdUnid;
  final String? unid;
  final String? habCappeso;
  final double? percToleranciaFc;
  final String? situacao;
  final String? qtdFormatada;
  final String? qtdTotalCxs;
  final double? peQtd;
  final String? peUnid;
  final double? fator;
  final String? fatorUn;

  ItensPedidoModel({
    this.codProd,
    this.descricao,
    this.procodbar,
    this.procodbarpe,
    this.fatObrgmultundsaux,
    this.qtd,
    this.qtdConfFat,
    this.item,
    this.qtdUnid,
    this.unid,
    this.habCappeso,
    this.percToleranciaFc,
    this.situacao,
    this.qtdFormatada,
    this.qtdTotalCxs,
    this.peQtd,
    this.peUnid,
    this.fator,
    this.fatorUn,
  });

  ItensPedidoModel copyWith({
    String? codProd,
    String? descricao,
    String? procodbar,
    String? procodbarpe,
    String? fatObrgmultundsaux,
    double? qtd,
    double? qtdConfFat,
    int? item,
    double? qtdUnid,
    String? unid,
    String? habCappeso,
    double? percToleranciaFc,
    String? situacao,
    String? qtdFormatada,
    String? qtdTotalCxs,
    double? peQtd,
    String? peUnid,
    double? fator,
    String? fatorUn,
  }) {
    return ItensPedidoModel(
      codProd: codProd ?? this.codProd,
      descricao: descricao ?? this.descricao,
      procodbar: procodbar ?? this.procodbar,
      procodbarpe: procodbarpe ?? this.procodbarpe,
      fatObrgmultundsaux: fatObrgmultundsaux ?? this.fatObrgmultundsaux,
      qtd: qtd ?? this.qtd,
      qtdConfFat: qtdConfFat ?? this.qtdConfFat,
      item: item ?? this.item,
      qtdUnid: qtdUnid ?? this.qtdUnid,
      unid: unid ?? this.unid,
      habCappeso: habCappeso ?? this.habCappeso,
      percToleranciaFc: percToleranciaFc ?? this.percToleranciaFc,
      situacao: situacao ?? this.situacao,
      qtdFormatada: qtdFormatada ?? this.qtdFormatada,
      qtdTotalCxs: qtdTotalCxs ?? this.qtdTotalCxs,
      peQtd: peQtd ?? this.peQtd,
      peUnid: peUnid ?? this.peUnid,
      fator: fator ?? this.fator,
      fatorUn: fatorUn ?? this.fatorUn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codProd': codProd,
      'descricao': descricao,
      'procodbar': procodbar,
      'procodbarpe': procodbarpe,
      'fatObrgmultundsaux': fatObrgmultundsaux,
      'qtd': qtd,
      'qtdConfFat': qtdConfFat,
      'item': item,
      'qtdUnid': qtdUnid,
      'unid': unid,
      'habCappeso': habCappeso,
      'percToleranciaFc': percToleranciaFc,
      'situacao': situacao,
      'qtdFormatada': qtdFormatada,
      'qtdTotalCxs': qtdTotalCxs,
      'peQtd': peQtd,
      'peUnid': peUnid,
      'fator': fator,
      'fatorUn': fatorUn,
    };
  }

  factory ItensPedidoModel.fromMap(Map<String, dynamic> map) {
    return ItensPedidoModel(
      codProd: map['codProd'],
      descricao: map['descricao'],
      procodbar: map['procodbar'],
      procodbarpe: map['procodbarpe'],
      fatObrgmultundsaux: map['fatObrgmultundsaux'],
      qtd: map['qtd'],
      qtdConfFat: map['qtdConfFat'],
      item: map['item'],
      qtdUnid: map['qtdUnid'],
      unid: map['unid'],
      habCappeso: map['habCappeso'],
      percToleranciaFc: map['percToleranciaFc'],
      situacao: map['situacao'],
      qtdFormatada: map['qtdFormatada'],
      qtdTotalCxs: map['qtdTotalCxs'],
      peQtd: map['peQtd'],
      peUnid: map['peUnid'],
      fator: map['fator'],
      fatorUn: map['fatorUn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItensPedidoModel.fromJson(Map<String, dynamic> json) {
    return ItensPedidoModel(
      codProd: json['cod_prod'],
      descricao: json['descricao'],
      procodbar: json['procodbar'] ?? '',
      procodbarpe: json['procodbarpe'] ?? '',
      fatObrgmultundsaux: json['fat_obrgmultundsaux'],
      qtd: json['qtd'],
      qtdConfFat: json['qtdconf_fat'],
      item: json['item'],
      unid: json['unid'],
      habCappeso: json['hab_cappeso'],
      percToleranciaFc: json['perc_tolerancia_fc'],
      situacao: json['situacao'],
      qtdFormatada: json['qtd_formatada'],
      qtdTotalCxs: json['qtd_total_cxs'],
      peQtd: json['pe_qtd'],
      peUnid: json['pe_unid'],
      fator: json['fator'],
      fatorUn: json['fatorun'],
    );
  }

  @override
  String toString() {
    return 'ItensPedidoModel(codProd: $codProd, descricao: $descricao, procodbar: $procodbar, procodbarpe: $procodbarpe, fatObrgmultundsaux: $fatObrgmultundsaux, qtd: $qtd, qtdConfFat: $qtdConfFat, item: $item, qtdUnid: $qtdUnid, unid: $unid, habCappeso: $habCappeso, percToleranciaFc: $percToleranciaFc, situacao: $situacao, qtdFormatada: $qtdFormatada, qtdTotalCxs: $qtdTotalCxs, peQtd: $peQtd, peUnid: $peUnid, fator: $fator, fatorUn: $fatorUn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItensPedidoModel &&
        other.codProd == codProd &&
        other.descricao == descricao &&
        other.procodbar == procodbar &&
        other.procodbarpe == procodbarpe &&
        other.fatObrgmultundsaux == fatObrgmultundsaux &&
        other.qtd == qtd &&
        other.qtdConfFat == qtdConfFat &&
        other.item == item &&
        other.qtdUnid == qtdUnid &&
        other.unid == unid &&
        other.habCappeso == habCappeso &&
        other.percToleranciaFc == percToleranciaFc &&
        other.situacao == situacao &&
        other.qtdFormatada == qtdFormatada &&
        other.qtdTotalCxs == qtdTotalCxs &&
        other.peQtd == peQtd &&
        other.peUnid == peUnid &&
        other.fator == fator &&
        other.fatorUn == fatorUn;
  }

  @override
  int get hashCode {
    return codProd.hashCode ^
        descricao.hashCode ^
        procodbar.hashCode ^
        procodbarpe.hashCode ^
        fatObrgmultundsaux.hashCode ^
        qtd.hashCode ^
        qtdConfFat.hashCode ^
        item.hashCode ^
        qtdUnid.hashCode ^
        unid.hashCode ^
        habCappeso.hashCode ^
        percToleranciaFc.hashCode ^
        situacao.hashCode ^
        qtdFormatada.hashCode ^
        qtdTotalCxs.hashCode ^
        peQtd.hashCode ^
        peUnid.hashCode ^
        fator.hashCode ^
        fatorUn.hashCode;
  }
}
