class Motorista {
  String? celularId;
  String? nome;

  Motorista({
    this.celularId,
    this.nome,
  });

  factory Motorista.fromJson(Map<String, dynamic> parsedJson) {
    return Motorista(
      celularId: parsedJson['celular_id'],
      nome: parsedJson['nome'],
    );
  }
}
