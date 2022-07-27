import 'dart:convert';

class BarCodeScannerModel {
  final bool isCameraAvaliable;
  final String error;
  final String barcode;
  final bool stopScanner;

  BarCodeScannerModel({
    this.isCameraAvaliable = false,
    this.error = '',
    this.barcode = '',
    this.stopScanner = false,
  });

  factory BarCodeScannerModel.avaliable() =>
      BarCodeScannerModel(isCameraAvaliable: true, stopScanner: false);

  factory BarCodeScannerModel.error(String message) =>
      BarCodeScannerModel(error: message, stopScanner: true);

  factory BarCodeScannerModel.barcode(String barcode) =>
      BarCodeScannerModel(barcode: barcode, stopScanner: true);

  bool get showCamera => isCameraAvaliable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarCode => barcode.isNotEmpty;
}

class BarCodeModel {
  final String msgRetorno;
  final int codRetorno;
  BarCodeModel({
    required this.msgRetorno,
    required this.codRetorno,
  });

  BarCodeModel copyWith({
    String? msgRetorno,
    int? codRetorno,
  }) {
    return BarCodeModel(
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

  factory BarCodeModel.fromMap(Map<String, dynamic> map) {
    return BarCodeModel(
      msgRetorno: map['msgRetorno'],
      codRetorno: map['codRetorno'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BarCodeModel.fromJson(Map<String, dynamic> json) {
    return BarCodeModel(
      msgRetorno: json['msg_retorno'],
      codRetorno: json['cod_retorno'],
    );
  }

  @override
  String toString() =>
      'BarCodeModel(msgRetorno: $msgRetorno, codRetorno: $codRetorno)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BarCodeModel &&
        other.msgRetorno == msgRetorno &&
        other.codRetorno == codRetorno;
  }

  @override
  int get hashCode => msgRetorno.hashCode ^ codRetorno.hashCode;
}
