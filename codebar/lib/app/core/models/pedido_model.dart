import 'dart:convert';

class PedidoModel {
  final int? codEmp;
  final int? codPed;
  final String? razaoSocial;
  final String? nomeFantasia;
  final String? situacao;
  final String? spPedCplt;
  final String? statusPed;
  final String? descricaoStatusPed;
  final int? qtdItens;
  PedidoModel({
    this.codEmp,
    this.codPed,
    this.razaoSocial,
    this.nomeFantasia,
    this.situacao,
    this.spPedCplt,
    this.statusPed,
    this.descricaoStatusPed,
    this.qtdItens,
  });

  PedidoModel copyWith({
    int? codEmp,
    int? codPed,
    String? razaoSocial,
    String? nomeFantasia,
    String? situacao,
    String? spPedCplt,
    String? statusPed,
    String? descricaoStatusPed,
    int? qtdItens,
  }) {
    return PedidoModel(
      codEmp: codEmp ?? this.codEmp,
      codPed: codPed ?? this.codPed,
      razaoSocial: razaoSocial ?? this.razaoSocial,
      nomeFantasia: nomeFantasia ?? this.nomeFantasia,
      situacao: situacao ?? this.situacao,
      spPedCplt: spPedCplt ?? this.spPedCplt,
      statusPed: statusPed ?? this.statusPed,
      descricaoStatusPed: descricaoStatusPed ?? this.descricaoStatusPed,
      qtdItens: qtdItens ?? this.qtdItens,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codEmp': codEmp,
      'codPed': codPed,
      'razaoSocial': razaoSocial,
      'nomeFantasia': nomeFantasia,
      'situacao': situacao,
      'spPedCplt': spPedCplt,
      'statusPed': statusPed,
      'descricaoStatusPed': descricaoStatusPed,
      'qtdItens': qtdItens,
    };
  }

  factory PedidoModel.fromMap(Map<String, dynamic> map) {
    return PedidoModel(
      codEmp: map['codEmp'],
      codPed: map['codPed'],
      razaoSocial: map['razaoSocial'],
      nomeFantasia: map['nomeFantasia'],
      situacao: map['situacao'],
      spPedCplt: map['spPedCplt'],
      statusPed: map['statusPed'],
      descricaoStatusPed: map['descricaoStatusPed'],
      qtdItens: map['qtdItens'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    return PedidoModel(
      codEmp: json['cod_emp'],
      codPed: json['cod_ped'],
      razaoSocial: json['razao_social'],
      nomeFantasia: json['nome_fantasia'],
      situacao: json['situacao'],
      spPedCplt: json['sp_ped_cplt'],
      statusPed: json['status_ped'],
      descricaoStatusPed: json['descricao_status_ped'],
      qtdItens: json['qtd_itens'],
    );
  }

  @override
  String toString() {
    return 'PedidoModel(codEmp: $codEmp, codPed: $codPed, razaoSocial: $razaoSocial, nomeFantasia: $nomeFantasia, situacao: $situacao, spPedCplt: $spPedCplt, statusPed: $statusPed, descricaoStatusPed: $descricaoStatusPed, qtdItens: $qtdItens)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PedidoModel &&
        other.codEmp == codEmp &&
        other.codPed == codPed &&
        other.razaoSocial == razaoSocial &&
        other.nomeFantasia == nomeFantasia &&
        other.situacao == situacao &&
        other.spPedCplt == spPedCplt &&
        other.statusPed == statusPed &&
        other.descricaoStatusPed == descricaoStatusPed &&
        other.qtdItens == qtdItens;
  }

  @override
  int get hashCode {
    return codEmp.hashCode ^
        codPed.hashCode ^
        razaoSocial.hashCode ^
        nomeFantasia.hashCode ^
        situacao.hashCode ^
        spPedCplt.hashCode ^
        statusPed.hashCode ^
        descricaoStatusPed.hashCode ^
        qtdItens.hashCode;
  }
}
