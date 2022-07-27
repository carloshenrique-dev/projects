import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class OcorrenciasModel {
  final bool? aceitaDev;
  final bool? ativo;
  final String? descricao;
  final bool? ocoPositiva;
  final String? id;
  OcorrenciasModel({
    this.aceitaDev,
    this.ativo,
    this.descricao,
    this.ocoPositiva,
    this.id,
  });

  OcorrenciasModel copyWith({
    bool? aceitaDev,
    bool? ativo,
    String? descricao,
    bool? ocoPositiva,
    String? id,
  }) {
    return OcorrenciasModel(
      aceitaDev: aceitaDev ?? this.aceitaDev,
      ativo: ativo ?? this.ativo,
      descricao: descricao ?? this.descricao,
      ocoPositiva: ocoPositiva ?? this.ocoPositiva,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'aceitaDev': aceitaDev,
      'ativo': ativo,
      'descricao': descricao,
      'ocoPositiva': ocoPositiva,
      'id': id,
    };
  }

  factory OcorrenciasModel.fromMap(Map<String, dynamic> map) {
    return OcorrenciasModel(
      aceitaDev: map['aceitaDev'] ?? false,
      ativo: map['ativo'] ?? false,
      descricao: map['descricao'] ?? '',
      ocoPositiva: map['ocoPositiva'] ?? false,
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OcorrenciasModel.fromJson(Map<String, dynamic> json) {
    return OcorrenciasModel(
      aceitaDev: json['aceitaDev'],
      ativo: json['ativo'],
      descricao: json['descricao'],
      ocoPositiva: json['ocoPositiva'],
    );
  }

  factory OcorrenciasModel.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    return OcorrenciasModel(
      id: documentSnapshot.id,
      aceitaDev: documentSnapshot['aceitaDev'],
      ativo: documentSnapshot['ativo'],
      descricao: documentSnapshot['descricao'],
      ocoPositiva: documentSnapshot['ocoPositiva'],
    );
  }

  @override
  String toString() {
    return 'OcorrenciasModel(aceitaDev: $aceitaDev, ativo: $ativo, descricao: $descricao, ocoPositiva: $ocoPositiva, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OcorrenciasModel &&
        other.aceitaDev == aceitaDev &&
        other.ativo == ativo &&
        other.descricao == descricao &&
        other.ocoPositiva == ocoPositiva &&
        other.id == id;
  }

  @override
  int get hashCode {
    return aceitaDev.hashCode ^
        ativo.hashCode ^
        descricao.hashCode ^
        ocoPositiva.hashCode ^
        id.hashCode;
  }
}
