import 'dart:convert';

class ConfigModel {
  final int? codFilterProd;
  final int? codFilterCli;

  ConfigModel({this.codFilterProd, this.codFilterCli});

  ConfigModel copyWith({
    int? codFilterProd,
    int? codFilterCli,
  }) {
    return ConfigModel(
      codFilterProd: codFilterProd ?? this.codFilterProd,
      codFilterCli: codFilterCli ?? this.codFilterCli,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codFilterProd': codFilterProd,
      'codFilterCli': codFilterCli,
    };
  }

  factory ConfigModel.fromMap(Map<String, dynamic> map) {
    return ConfigModel(
      codFilterProd: map['codFilterProd']?.toInt() ?? 0,
      codFilterCli: map['codFilterCli']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigModel.fromJson(String source) =>
      ConfigModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ConfigModel(codFilterProd: $codFilterProd, codFilterCli: $codFilterCli)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfigModel &&
        other.codFilterProd == codFilterProd &&
        other.codFilterCli == codFilterCli;
  }

  @override
  int get hashCode => codFilterProd.hashCode ^ codFilterCli.hashCode;
}
