import 'package:up_codebar/app/core/models/default_return_model.dart';
import 'package:up_codebar/app/core/repositories/devolution/devolution_repository.dart';
import './devolution_view_model.dart';

class DevolutionViewModelImpl implements DevolutionViewModel {
  final DevolutionRepository _devolutionRepository;
  DevolutionViewModelImpl({
    required DevolutionRepository devolutionRepository,
  }) : _devolutionRepository = devolutionRepository;
  @override
  Future<DefaultReturnModel> setItemDevol(
          {required String codEtiqueta, required String tipo}) =>
      _devolutionRepository.setItemDevol(codEtiqueta: codEtiqueta, tipo: tipo);
}
