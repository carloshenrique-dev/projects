import 'package:up_codebar/app/core/models/barcode_scanner_model.dart';
import 'package:up_codebar/app/core/repositories/barcode/barcode_repository.dart';
import './barcode_view_model.dart';

class BarcodeViewModelImpl implements BarcodeViewModel {
  final BarcodeRepository _barCodeRepository;
  BarcodeViewModelImpl({
    required BarcodeRepository barCodeRepository,
  }) : _barCodeRepository = barCodeRepository;

  @override
  Future<BarCodeModel> setItensLote(
          {required int codLote,
          required int codProd,
          required double qtdDigitada,
          required String codEtiqueta,
          required String usuarioCodeBar}) =>
      _barCodeRepository.setItensLote(
          codLote: codLote,
          codProd: codProd,
          qtdDigitada: qtdDigitada,
          codEtiqueta: codEtiqueta,
          usuarioCodeBar: usuarioCodeBar);

  @override
  Future<BarCodeModel> setItensPedido(
          {required int codPed,
          required int item,
          required int numCaixa,
          required int codProd,
          required double pesoCx,
          required int qtdEtiq,
          required String codEtiqueta,
          required String usuarioCodeBar}) =>
      _barCodeRepository.setItensPedido(
          codPed: codPed,
          item: item,
          numCaixa: numCaixa,
          codProd: codProd,
          pesoCx: pesoCx,
          qtdEtiq: qtdEtiq,
          codEtiqueta: codEtiqueta,
          usuarioCodeBar: usuarioCodeBar);
}
