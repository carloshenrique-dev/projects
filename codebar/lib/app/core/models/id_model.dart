import 'dart:convert';

class IDmodel {
  final String? idCliente;
  final String? senha;
  IDmodel({
    this.idCliente,
    this.senha,
  });

  IDmodel copyWithID({
    String? idCliente,
    String? senha,
  }) {
    return IDmodel(
      idCliente: idCliente ?? this.idCliente,
      senha: senha ?? this.senha,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idCliente': idCliente,
      'senha': senha,
    };
  }

  factory IDmodel.fromMap(Map<String, dynamic> map) {
    return IDmodel(
      idCliente: map['idCliente'],
      senha: map['senha'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IDmodel.fromJson(String source) =>
      IDmodel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(usuario: $idCliente, senha: $senha)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IDmodel && other.idCliente == idCliente && other.senha == senha;
  }

  @override
  int get hashCode => idCliente.hashCode ^ senha.hashCode;
}
