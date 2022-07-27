import 'package:up_codebar/app/core/models/barcode_scanner_model.dart';

abstract class BarcodeViewModel {
  Future<BarCodeModel> setItensLote({
    required int codLote,
    required int codProd,
    required double qtdDigitada,
    required String codEtiqueta,
    required String usuarioCodeBar,
  });

  Future<BarCodeModel> setItensPedido({
    required int codPed,
    required int item,
    required int numCaixa,
    required int codProd,
    required double pesoCx,
    required int qtdEtiq,
    required String codEtiqueta,
    required String usuarioCodeBar,
  });
}
