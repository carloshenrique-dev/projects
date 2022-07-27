import 'package:get/get.dart';
import 'package:up_codebar/app/core/repositories/inventory/inventory_repository.dart';
import 'package:up_codebar/app/core/repositories/inventory/inventory_repository_impl.dart';
import 'package:up_codebar/app/core/view_models/inventory/inventory_view_model.dart';
import 'package:up_codebar/app/core/view_models/inventory/inventory_view_model_impl.dart';
import 'package:up_codebar/modules/inventory/inventory_controller.dart';

class InventoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryRepository>(
      () => InventoryRepositoryImpl(apiServices: Get.find()),
    );
    Get.lazyPut<InventoryViewModel>(
      () => InventoryViewModelImpl(inventoryRepository: Get.find()),
    );
    Get.lazyPut(
      () => InventoryController(
          inventoryViewModel: Get.find(), storage: Get.find()),
    );
  }
}
