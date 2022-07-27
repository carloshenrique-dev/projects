import 'dart:convert';

class TipoSetorEstoqueModel {
  final int? tipo;
  final String? tipoSetor;
  final String? combo;
  TipoSetorEstoqueModel({
    this.tipo,
    this.tipoSetor,
    this.combo,
  });

  TipoSetorEstoqueModel copyWith({
    int? tipo,
    String? tipoSetor,
    String? combo,
  }) {
    return TipoSetorEstoqueModel(
      tipo: tipo ?? this.tipo,
      tipoSetor: tipoSetor ?? this.tipoSetor,
      combo: combo ?? this.combo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'tipoSetor': tipoSetor,
      'combo': combo,
    };
  }

  factory TipoSetorEstoqueModel.fromMap(Map<String, dynamic> map) {
    return TipoSetorEstoqueModel(
      tipo: map['tipo'],
      tipoSetor: map['tipoSetor'],
      combo: map['combo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoSetorEstoqueModel.fromJson(Map<String, dynamic> json) {
    return TipoSetorEstoqueModel(
      tipo: json['tipo'],
      tipoSetor: json['tipo_setor'],
      combo: json['combo'],
    );
  }

  static List<TipoSetorEstoqueModel> fromJsonList(List list) {
    return list.map((item) => TipoSetorEstoqueModel.fromJson(item)).toList();
  }

  @override
  String toString() =>
      'TipoSetorEstoqueModel(tipo: $tipo, tipoSetor: $tipoSetor, combo: $combo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TipoSetorEstoqueModel &&
        other.tipo == tipo &&
        other.tipoSetor == tipoSetor &&
        other.combo == combo;
  }

  @override
  int get hashCode => tipo.hashCode ^ tipoSetor.hashCode ^ combo.hashCode;
}
