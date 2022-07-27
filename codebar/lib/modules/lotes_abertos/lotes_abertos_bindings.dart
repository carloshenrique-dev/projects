import 'package:get/get.dart';
import 'package:up_codebar/app/core/repositories/lotes_abertos/lotes_abertos_repository.dart';
import 'package:up_codebar/app/core/repositories/lotes_abertos/lotes_abertos_repository_impl.dart';
import 'package:up_codebar/app/core/view_models/lotes_abertos/lotes_abertos_list_view_model.dart';
import 'package:up_codebar/app/core/view_models/lotes_abertos/lotes_abertos_list_view_model_impl.dart';
import 'package:up_codebar/modules/lotes_abertos/lotes_abertos_controller.dart';

class LotesAbertosBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LotesAbertosRepository>(
        () => LotesAbertosRepositoryImpl(apiServices: Get.find()),
        fenix: true);
    Get.lazyPut<LotesAbertosListViewModel>(
        () => LotesAbertosListViewModelImpl(lotesAbertosRepository: Get.find()),
        fenix: true);
    Get.lazyPut<LotesAbertosController>(
      () => LotesAbertosController(
        lotesAbertosListViewModel: Get.find<LotesAbertosListViewModel>(),
      ),
      fenix: true,
    );
  }
}
