import 'dart:convert';

class DefaultReturnModel {
  final String msgRetorno;
  final int codRetorno;
  DefaultReturnModel({
    required this.msgRetorno,
    required this.codRetorno,
  });

  DefaultReturnModel copyWith({
    String? msgRetorno,
    int? codRetorno,
  }) {
    return DefaultReturnModel(
      msgRetorno: msgRetorno ?? this.msgRetorno,
      codRetorno: codRetorno ?? this.codRetorno,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'msgRetorno': msgRetorno,
      'codRetorno': codRetorno,
    };
  }

  factory DefaultReturnModel.fromMap(Map<String, dynamic> map) {
    return DefaultReturnModel(
      msgRetorno: map['msgRetorno'],
      codRetorno: map['codRetorno'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DefaultReturnModel.fromJson(Map<String, dynamic> json) {
    return DefaultReturnModel(
        msgRetorno: json['msg_retorno'], codRetorno: json['cod_retorno']);
  }

  @override
  String toString() =>
      'DefaultReturnModel(msgRetorno: $msgRetorno, codRetorno: $codRetorno)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DefaultReturnModel &&
        other.msgRetorno == msgRetorno &&
        other.codRetorno == codRetorno;
  }

  @override
  int get hashCode => msgRetorno.hashCode ^ codRetorno.hashCode;
}
