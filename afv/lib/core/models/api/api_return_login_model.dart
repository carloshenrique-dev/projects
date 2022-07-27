import 'dart:convert';

class ApiReturnLoginModel {
  final String? idPda;
  final String? situacao;
  final String? dispositivo;
  final int? codVend;
  final String? nomeVend;
  ApiReturnLoginModel({
    this.idPda,
    this.situacao,
    this.dispositivo,
    this.codVend,
    this.nomeVend,
  });

  ApiReturnLoginModel copyWith({
    String? idPda,
    String? situacao,
    String? dispositivo,
    int? codVend,
    String? nomeVend,
  }) {
    return ApiReturnLoginModel(
      idPda: idPda ?? this.idPda,
      situacao: situacao ?? this.situacao,
      dispositivo: dispositivo ?? this.dispositivo,
      codVend: codVend ?? this.codVend,
      nomeVend: nomeVend ?? this.nomeVend,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idPda': idPda,
      'situacao': situacao,
      'dispositivo': dispositivo,
      'codVend': codVend,
      'nomeVend': nomeVend,
    };
  }

  factory ApiReturnLoginModel.fromMap(Map<String, dynamic> map) {
    return ApiReturnLoginModel(
      idPda: map['idPda'],
      situacao: map['situacao'],
      dispositivo: map['dispositivo'],
      codVend: map['codVend']?.toInt(),
      nomeVend: map['nomeVend'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiReturnLoginModel.fromJson(Map<String, dynamic> json) {
    return ApiReturnLoginModel(
      idPda: json['idPda'],
      situacao: json['situacao'],
      dispositivo: json['dispositivo'],
      codVend: json['codVend']?.toInt(),
      nomeVend: json['nomeVend'],
    );
  }

  @override
  String toString() {
    return 'ApiReturnLoginModel(idPda: $idPda, situacao: $situacao, dispositivo: $dispositivo, codVend: $codVend, nomeVend: $nomeVend)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiReturnLoginModel &&
        other.idPda == idPda &&
        other.situacao == situacao &&
        other.dispositivo == dispositivo &&
        other.codVend == codVend &&
        other.nomeVend == nomeVend;
  }

  @override
  int get hashCode {
    return idPda.hashCode ^
        situacao.hashCode ^
        dispositivo.hashCode ^
        codVend.hashCode ^
        nomeVend.hashCode;
  }
}
