import 'package:get/get.dart';
import './financial_position_controller.dart';

class FinancialPositionBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(FinancialPositionController(customersViewModel: Get.find()));
  }
}
