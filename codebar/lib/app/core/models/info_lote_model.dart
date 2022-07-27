import 'dart:convert';

class InfoLoteModel {
  final String? itinerario;
  final String? veiculo;
  final int? codigo;
  final int? codPed;
  InfoLoteModel({
    this.itinerario,
    this.veiculo,
    this.codigo,
    this.codPed,
  });

  InfoLoteModel copyWith({
    String? itinerario,
    String? veiculo,
    int? codigo,
    int? codPed,
  }) {
    return InfoLoteModel(
      itinerario: itinerario ?? this.itinerario,
      veiculo: veiculo ?? this.veiculo,
      codigo: codigo ?? this.codigo,
      codPed: codPed ?? this.codPed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itinerario': itinerario,
      'veiculo': veiculo,
      'codigo': codigo,
      'codPed': codPed,
    };
  }

  factory InfoLoteModel.fromMap(Map<String, dynamic> map) {
    return InfoLoteModel(
      itinerario: map['itinerario'] ?? '',
      veiculo: map['veiculo'] ?? '',
      codigo: map['codigo'] ?? 0,
      codPed: map['codPed'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoLoteModel.fromJson(String source) =>
      InfoLoteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InfoLoteModel(itinerario: $itinerario, veiculo: $veiculo, codigo: $codigo, codPed: $codPed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InfoLoteModel &&
        other.itinerario == itinerario &&
        other.veiculo == veiculo &&
        other.codigo == codigo &&
        other.codPed == codPed;
  }

  @override
  int get hashCode {
    return itinerario.hashCode ^
        veiculo.hashCode ^
        codigo.hashCode ^
        codPed.hashCode;
  }
}
