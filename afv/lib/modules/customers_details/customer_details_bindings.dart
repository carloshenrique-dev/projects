import 'package:get/get.dart';
import 'customer_details_controller.dart';

class CustomerDetailsBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(CustomerDetailsController(customersViewModel: Get.find()));
    }
}