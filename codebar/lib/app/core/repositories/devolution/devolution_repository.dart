import 'package:up_codebar/app/core/models/default_return_model.dart';

abstract class DevolutionRepository {
  Future<DefaultReturnModel> setItemDevol(
      {required String codEtiqueta, required String tipo});
}
