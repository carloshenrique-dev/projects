import 'dart:convert';

class LicencasModel {
  final int? situacao;
  final String? senha;
  final int? sequencia;
  final String? descricao;
  final String? dispositivo;
  LicencasModel({
    this.situacao,
    this.senha,
    this.sequencia,
    this.descricao,
    this.dispositivo,
  });

  LicencasModel copyWith({
    int? situacao,
    String? senha,
    int? sequencia,
    String? descricao,
    String? dispositivo,
  }) {
    return LicencasModel(
      situacao: situacao ?? this.situacao,
      senha: senha ?? this.senha,
      sequencia: sequencia ?? this.sequencia,
      descricao: descricao ?? this.descricao,
      dispositivo: dispositivo ?? this.dispositivo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'situacao': situacao,
      'senha': senha,
      'sequencia': sequencia,
      'descricao': descricao,
      'dispositivo': dispositivo,
    };
  }

  factory LicencasModel.fromMap(Map<String, dynamic> map) {
    return LicencasModel(
      situacao: map['situacao'],
      senha: map['senha'],
      sequencia: map['sequencia'],
      descricao: map['descricao'],
      dispositivo: map['dispositivo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LicencasModel.fromJson(Map<String, dynamic> json) {
    return LicencasModel(
      descricao: json['descricao'],
      dispositivo: json['dispositivo'] ?? '',
      senha: json['senha'],
      sequencia: json['sequencia'],
      situacao: json['situacao'],
    );
  }

  @override
  String toString() {
    return 'LicencasModel(situacao: $situacao, senha: $senha, sequencia: $sequencia, descricao: $descricao, dispositivo: $dispositivo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LicencasModel &&
        other.situacao == situacao &&
        other.senha == senha &&
        other.sequencia == sequencia &&
        other.descricao == descricao &&
        other.dispositivo == dispositivo;
  }

  @override
  int get hashCode {
    return situacao.hashCode ^
        senha.hashCode ^
        sequencia.hashCode ^
        descricao.hashCode ^
        dispositivo.hashCode;
  }
}
