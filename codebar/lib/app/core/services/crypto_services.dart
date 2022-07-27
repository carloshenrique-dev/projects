import 'package:charset_converter/charset_converter.dart';
import 'dart:typed_data';
import 'dart:math';

class Crypto {
  crypto(String texto, String modo, String chave) async {
    String? tmpText;
    int numero;
    List<int> ord;
    Uint8List encoded = await CharsetConverter.encode('windows1252', texto);
    if (texto.isNotEmpty) {
      if (modo == 'E') {
        if (chave.length != 1) {
          var random = Random.secure();
          numero = 0;
          while (numero < 100) {
            numero = random.nextInt(256);
          }
          chave = String.fromCharCode(numero);
        }
        tmpText = chave;
        ord = <int>[];
        for (int i = 0; i <= encoded.length - 1; i++) {
          int value = encoded[i] + 10 + retornaPuro(chave.runes.single);
          ord.add(value);
        }
        String? decoded = await (CharsetConverter.decode(
            'windows1252', Uint8List.fromList(ord)));
        tmpText = tmpText + decoded;
        return tmpText;
      } else {
        if (modo == 'D') {
          tmpText = '';
          if (chave.length != 1) chave = texto.substring(0, 1);
          if (chave == texto.substring(0, 1)) {
            ord = <int>[];
            for (int i = 1; i <= encoded.length - 1; i++) {
              int value = encoded[i] - 10 - retornaPuro(chave.runes.single);
              ord.add(value);
            }
            String? decoded = await (CharsetConverter.decode(
                'windows1252', Uint8List.fromList(ord)));
            tmpText = tmpText + decoded;
            return tmpText;
          } else {
            throw Exception('Chave de Descriptografia inválida!');
          }
        } else {
          throw Exception('Modo inválido!');
        }
      }
    }

    return tmpText;
  }

  static int retornaPuro(int numero) {
    String texto;
    int auxNum, tmpResult;
    tmpResult = numero;
    while (tmpResult > 9) {
      auxNum = 0;
      texto = tmpResult.toString();
      for (int i = 0; i < texto.length; i++) {
        auxNum = auxNum + int.parse(texto.substring(i, i + 1));
      }
      tmpResult = auxNum;
    }
    return tmpResult;
  }
}
