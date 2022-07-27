import 'dart:convert';

class UserModel {
  final String? usuario;
  final String? senha;
  UserModel({
    this.usuario,
    this.senha,
  });

  UserModel copyWith({
    String? usuario,
    String? senha,
  }) {
    return UserModel(
      usuario: usuario ?? this.usuario,
      senha: senha ?? this.senha,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      'senha': senha,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      usuario: map['usuario'],
      senha: map['senha'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(usuario: $usuario, senha: $senha)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.usuario == usuario &&
        other.senha == senha;
  }

  @override
  int get hashCode => usuario.hashCode ^ senha.hashCode;
}
