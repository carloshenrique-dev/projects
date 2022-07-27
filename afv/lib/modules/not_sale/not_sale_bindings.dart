import 'package:get/get.dart';
import 'package:up_afv/core/repositories/not_sale/not_sale_repository.dart';
import 'package:up_afv/core/repositories/not_sale/not_sale_repository_impl.dart';
import 'package:up_afv/core/view_models/not_sale/not_sale_view_model.dart';
import 'package:up_afv/core/view_models/not_sale/not_sale_view_model_impl.dart';
import './not_sale_controller.dart';

class NotSaleBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotSaleRepository>(
      () => NotSaleRepositoryImpl(
        dbService: Get.find(),
        apiProvider: Get.find(),
      ),
    );
    Get.lazyPut<NotSaleViewModel>(
      () => NotSaleViewModelImpl(
        notSaleRepository: Get.find(),
      ),
    );
    Get.lazyPut<NotSaleController>(
        () => NotSaleController(notSaleViewModel: Get.find()));
  }
}
