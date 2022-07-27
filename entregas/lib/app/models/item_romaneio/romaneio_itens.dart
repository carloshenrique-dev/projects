import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RomaneioItens {
  final String? id;
  final int? codFil;
  final String? tipoDocto;
  final String? serie;
  final bool? rotaEntrega;
  final bool? entregaConcluida;
  final String? obsPedido;
  final int? codPed;
  final int? seq;
  final Map? cliente;
  final Map? enderecoEntrega;

  RomaneioItens({
    this.id,
    this.codFil,
    this.tipoDocto,
    this.serie,
    this.rotaEntrega,
    this.entregaConcluida,
    this.obsPedido,
    this.codPed,
    this.seq,
    this.cliente,
    this.enderecoEntrega,
  });

  RomaneioItens copyWith({
    String? id,
    bool? rotaEntrega,
    bool? entregaConcluida,
    String? obsPedido,
    int? codPed,
    Map? cliente,
    Map? enderecoEntrega,
  }) {
    return RomaneioItens(
      id: id ?? this.id,
      rotaEntrega: rotaEntrega ?? this.rotaEntrega,
      entregaConcluida: entregaConcluida ?? this.entregaConcluida,
      obsPedido: obsPedido ?? this.obsPedido,
      codPed: codPed ?? this.codPed,
      cliente: cliente ?? this.cliente,
      enderecoEntrega: enderecoEntrega ?? this.enderecoEntrega,
      seq: seq ?? seq,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rotaEntrega': rotaEntrega,
      'entregaConcluida': entregaConcluida,
      'obsPedido': obsPedido,
      'codPed': codPed,
      'cliente': cliente,
      'enderecoEntrega': enderecoEntrega,
      'seq': seq,
    };
  }

  factory RomaneioItens.fromMap(Map<String, dynamic> map, String id) {
    return RomaneioItens(
      id: id,
      rotaEntrega: map['rotaEntrega'] ?? false,
      entregaConcluida: map['entregaConcluida'] ?? false,
      obsPedido: map['obsPedido'] ?? '',
      codPed: map['codPed'] ?? 0,
      cliente: map['cliente'] ?? {},
      enderecoEntrega: map['enderecoEntrega'] ?? {},
      seq: map['seq'],
    );
  }

  factory RomaneioItens.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot, String id) {
    return RomaneioItens(
        id: id,
        cliente: documentSnapshot['cliente'] ?? {},
        codPed: documentSnapshot['codPed'] ?? 0,
        enderecoEntrega: documentSnapshot['enderecoEntrega'] ?? {},
        entregaConcluida: documentSnapshot['entregaConcluida'] ?? false,
        obsPedido: documentSnapshot['obsPedido'] ?? '',
        rotaEntrega: documentSnapshot['rotaEntrega'] ?? false,
        seq: documentSnapshot['seq'] ?? 0,
        tipoDocto: documentSnapshot['tipoDocto'] ?? '',
        codFil: documentSnapshot['codFil'] ?? 0,
        serie: documentSnapshot['serie'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory RomaneioItens.fromJson(String source, id) =>
      RomaneioItens.fromMap(json.decode(source), id);

  @override
  String toString() {
    return 'RomaneioItens(id: $id, rotaEntrega: $rotaEntrega, entregaConcluida: $entregaConcluida, obsPedido: $obsPedido, codPed: $codPed, cliente: $cliente, enderecoEntrega: $enderecoEntrega, seq: $seq)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RomaneioItens &&
        other.id == id &&
        other.rotaEntrega == rotaEntrega &&
        other.entregaConcluida == entregaConcluida &&
        other.obsPedido == obsPedido &&
        other.codPed == codPed &&
        other.cliente == cliente &&
        other.seq == seq &&
        other.enderecoEntrega == enderecoEntrega;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rotaEntrega.hashCode ^
        entregaConcluida.hashCode ^
        obsPedido.hashCode ^
        codPed.hashCode ^
        cliente.hashCode ^
        seq.hashCode ^
        enderecoEntrega.hashCode;
  }
}
