import 'package:get/get.dart';
import 'package:up_afv/core/repositories/customers/customers_repository.dart';
import 'package:up_afv/core/repositories/customers/customers_repository_impl.dart';
import 'package:up_afv/core/repositories/products/products_repository.dart';
import 'package:up_afv/core/repositories/products/products_repository_impl.dart';
import 'package:up_afv/core/view_models/customers/customers_view_model.dart';
import 'package:up_afv/core/view_models/customers/customers_view_model_impl.dart';
import 'package:up_afv/core/view_models/products/produtos_view_model.dart';
import 'package:up_afv/core/view_models/products/produtos_view_model_impl.dart';
import 'package:up_afv/core/repositories/not_sale/not_sale_repository.dart';
import 'package:up_afv/core/repositories/not_sale/not_sale_repository_impl.dart';
import 'package:up_afv/core/view_models/not_sale/not_sale_view_model.dart';
import 'package:up_afv/core/view_models/not_sale/not_sale_view_model_impl.dart';

import 'home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsRepository>(
      () => ProductsRepositoryImpl(
        dbService: Get.find(),
        apiProvider: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<ProductsViewModel>(
      () => ProductsViewModelImpl(
        productsRepository: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<CustomersRepository>(
      () => CustomersRepositoryImpl(
        dbService: Get.find(),
        apiProvider: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<CustomersViewModel>(() => CustomersViewModelImpl(
          customersRepository: Get.find(),
        ));
    Get.lazyPut<NotSaleRepository>(
      () => NotSaleRepositoryImpl(
        apiProvider: Get.find(),
        dbService: Get.find(),
      ),
    );

    Get.lazyPut<NotSaleViewModel>(
      () => NotSaleViewModelImpl(
        notSaleRepository: Get.find(),
      ),
    );

    Get.put(
      HomeController(
        productsViewModel: Get.find(),
        customersViewModel: Get.find(),
        loginViewModel: Get.find(),
        notSaleViewModel: Get.find(),
      ),
    );
  }
}
