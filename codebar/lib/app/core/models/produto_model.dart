import 'dart:convert';

class ProdutoModel {
  final String? codProd;
  final String? descricao;
  final String? descricaoProduto;
  final String? procodbar;
  final String? procodbarPe;
  final String? fatObrgmultUndSaux;
  final double? qtd;
  final double? qtdConfFat;
  final int? item;
  final double? qtdUnid;
  final String? unid;
  final String? habCapPeso;
  final double? percToleranciaFc;
  final String? situacao;
  final String? qtdFormatada;
  final double? peQtd;
  final String? peUnid;
  final double? fator;
  final String? fatorUn;

  ProdutoModel({
    this.codProd,
    this.descricao,
    this.descricaoProduto,
    this.procodbar,
    this.procodbarPe,
    this.fatObrgmultUndSaux,
    this.qtd,
    this.qtdConfFat,
    this.item,
    this.qtdUnid,
    this.unid,
    this.habCapPeso,
    this.percToleranciaFc,
    this.situacao,
    this.qtdFormatada,
    this.peQtd,
    this.peUnid,
    this.fator,
    this.fatorUn,
  });

  ProdutoModel copyWith({
    String? codProd,
    String? descricao,
    String? descricaoProduto,
    String? procodbar,
    String? procodbarPe,
    String? fatObrgmultUndSaux,
    double? qtd,
    double? qtdConfFat,
    int? item,
    double? qtdUnid,
    String? unid,
    String? habCapPeso,
    double? percToleranciaFc,
    String? situacao,
    String? qtdFormatada,
    double? peQtd,
    String? peUnid,
    double? fator,
    String? fatorUn,
  }) {
    return ProdutoModel(
      codProd: codProd ?? this.codProd,
      descricao: descricao ?? this.descricao,
      descricaoProduto: descricaoProduto ?? this.descricaoProduto,
      procodbar: procodbar ?? this.procodbar,
      procodbarPe: procodbarPe ?? this.procodbarPe,
      fatObrgmultUndSaux: fatObrgmultUndSaux ?? this.fatObrgmultUndSaux,
      qtd: qtd ?? this.qtd,
      qtdConfFat: qtdConfFat ?? this.qtdConfFat,
      item: item ?? this.item,
      qtdUnid: qtdUnid ?? this.qtdUnid,
      unid: unid ?? this.unid,
      habCapPeso: habCapPeso ?? this.habCapPeso,
      percToleranciaFc: percToleranciaFc ?? this.percToleranciaFc,
      situacao: situacao ?? this.situacao,
      qtdFormatada: qtdFormatada ?? this.qtdFormatada,
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
      'descricaoProduto': descricaoProduto,
      'procodbar': procodbar,
      'procodbarPe': procodbarPe,
      'fatObrgmultUndSaux': fatObrgmultUndSaux,
      'qtd': qtd,
      'qtdConfFat': qtdConfFat,
      'item': item,
      'qtdUnid': qtdUnid,
      'unid': unid,
      'habCapPeso': habCapPeso,
      'percToleranciaFc': percToleranciaFc,
      'situacao': situacao,
      'qtdFormatada': qtdFormatada,
      'peQtd': peQtd,
      'peUnid': peUnid,
      'fator': fator,
      'fatorUn': fatorUn,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      codProd: map['codProd'],
      descricao: map['descricao'],
      descricaoProduto: map['descricaoProduto'],
      procodbar: map['procodbar'],
      procodbarPe: map['procodbarPe'],
      fatObrgmultUndSaux: map['fatObrgmultUndSaux'],
      qtd: map['qtd'],
      qtdConfFat: map['qtdConfFat'],
      item: map['item'],
      qtdUnid: map['qtdUnid'],
      unid: map['unid'],
      habCapPeso: map['habCapPeso'],
      percToleranciaFc: map['percToleranciaFc'],
      situacao: map['situacao'],
      qtdFormatada: map['qtdFormatada'],
      peQtd: map['peQtd'],
      peUnid: map['peUnid'],
      fator: map['fator'],
      fatorUn: map['fatorUn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      codProd: json['cod_prod'],
      descricao: json['descricao'],
      descricaoProduto: json['descricao_produto'],
      procodbar: json['procodbar'] ?? '',
      procodbarPe: json['procodbarpe'] ?? '',
      fatObrgmultUndSaux: json['fat_obrgmultundsaux'],
      qtd: json['qtd'],
      qtdConfFat: json['qtdconf_fat'],
      item: json['item'],
      unid: json['unid'],
      habCapPeso: json['hab_cappeso'],
      percToleranciaFc: json['perc_tolerancia_fc'],
      situacao: json['situacao'],
      qtdFormatada: json['qtd_formatada'],
      peQtd: json['pe_qtd'],
      peUnid: json['pe_unid'],
      fator: json['fator'],
      fatorUn: json['fatorun'],
    );
  }

  @override
  String toString() {
    return 'ProdutoModel(codProd: $codProd, descricao: $descricao, descricaoProduto: $descricaoProduto, procodbar: $procodbar, procodbarPe: $procodbarPe, fatObrgmultUndSaux: $fatObrgmultUndSaux, qtd: $qtd, qtdConfFat: $qtdConfFat, item: $item, qtdUnid: $qtdUnid, unid: $unid, habCapPeso: $habCapPeso, percToleranciaFc: $percToleranciaFc, situacao: $situacao, qtdFormatada: $qtdFormatada, peQtd: $peQtd, peUnid: $peUnid, fator: $fator, fatorUn: $fatorUn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProdutoModel &&
        other.codProd == codProd &&
        other.descricao == descricao &&
        other.descricaoProduto == descricaoProduto &&
        other.procodbar == procodbar &&
        other.procodbarPe == procodbarPe &&
        other.fatObrgmultUndSaux == fatObrgmultUndSaux &&
        other.qtd == qtd &&
        other.qtdConfFat == qtdConfFat &&
        other.item == item &&
        other.qtdUnid == qtdUnid &&
        other.unid == unid &&
        other.habCapPeso == habCapPeso &&
        other.percToleranciaFc == percToleranciaFc &&
        other.situacao == situacao &&
        other.qtdFormatada == qtdFormatada &&
        other.peQtd == peQtd &&
        other.peUnid == peUnid &&
        other.fator == fator &&
        other.fatorUn == fatorUn;
  }

  @override
  int get hashCode {
    return codProd.hashCode ^
        descricao.hashCode ^
        descricaoProduto.hashCode ^
        procodbar.hashCode ^
        procodbarPe.hashCode ^
        fatObrgmultUndSaux.hashCode ^
        qtd.hashCode ^
        qtdConfFat.hashCode ^
        item.hashCode ^
        qtdUnid.hashCode ^
        unid.hashCode ^
        habCapPeso.hashCode ^
        percToleranciaFc.hashCode ^
        situacao.hashCode ^
        qtdFormatada.hashCode ^
        peQtd.hashCode ^
        peUnid.hashCode ^
        fator.hashCode ^
        fatorUn.hashCode;
  }
}
