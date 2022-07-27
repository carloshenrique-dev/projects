import 'package:intl/intl.dart';

mixin BarcodeServices {
  Map<String, String> validaBarCode(String barcode) {
    try {
      return {
        'lote': barcode.substring(2, 11),
        'item': barcode.substring(11, 14),
        'codProd': barcode.substring(18, 25),
        'qtd': barcode.substring(25, 28),
        'barcode': barcode,
        'validade': formatData(barcode.substring(32, 38)),
        'valido': 'valido',
      };
    } catch (e) {
      throw Exception(e);
    }
  }

  Map<String, dynamic> validaEtiquetaCodebar(String barcode) {
    /*var validade = validaData(formatData(barcode.substring(32, 38)));
    if (validade) {*/
    return {
      'lote': barcode.substring(2, 11),
      'item': barcode.substring(11, 14),
      'codProd': int.parse(barcode.substring(18, 25)).toString(),
      'qtd': barcode.substring(25, 32),
      'barcode': barcode,
      'validade': formatData(barcode.substring(32, 38)),
      'valido': 'valido',
    };
    /*}
    return {
      'barcode': barcode,
      'valido': 'vencido',
    };*/
  }

  Map<String, dynamic> validaEtiquetaPadaria(String barcode) {
    return {
      'codProd': int.parse(
        barcode
            .substring(2, 7)
            .toString()
            .replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), ''),
      ).toString(),
      'qtd': barcode.substring(7, 12),
      'barcode': barcode,
    };
  }

  //comparacao de validade do produto
  bool validaData(String data) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    var splitDate = data.split('/');
    if (int.parse(splitDate[0]) <= date.day &&
        int.parse(splitDate[1]) <= date.month &&
        int.parse(splitDate[2]) >= date.year) {
      return true;
    }
    return false;
  }

  //formatacao de data (xx/xx/xxxx)
  String formatData(String data) {
    var formattedData = data.substring(0, 2) +
        '-' +
        data.substring(2, 4) +
        '-' +
        data.substring(4, 6);
    var inputFormat = DateFormat('yy-MM-dd');
    var inputDate = inputFormat.parse(formattedData);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }
}

