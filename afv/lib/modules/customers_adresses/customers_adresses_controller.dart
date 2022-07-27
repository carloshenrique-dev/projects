import 'dart:async';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/ui/choose_navigation_dialog/choose_navigation_dialog_mixin.dart';
import 'package:up_afv/application/themes/ui/loader/loader_mixin.dart';
import 'package:up_afv/application/themes/ui/messages/messages_mixin.dart';
import 'package:up_afv/core/models/customers/customers_address_model.dart';
import 'package:up_afv/core/models/customers/customers_model.dart';
import 'package:up_afv/core/view_models/customers/customers_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomersAdressesController extends GetxController
    with MessagesMixin, LoaderMixin, ChooseNavigationDialogMixin {
  var customer = CustomersModel();
  final list = <CustomersAddressModel>[].obs;
  final CustomersViewModel _customersViewModel;
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final navigation = Rxn<ChooseNavigationModel>();
  var latitude = ''.obs;
  var longitude = ''.obs;
  StreamSubscription<Position>? getStreamSubscription;

  CustomersAdressesController({
    required CustomersViewModel customersViewModel,
  }) : _customersViewModel = customersViewModel;

  @override
  onInit() async {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    navigationListener(navigation);
    customer = Get.arguments;
    await getData();
  }

  @override
  onReady() async {
    super.onReady();
    await getPosition();
  }

  @override
  onClose() {
    super.onClose();
    getStreamSubscription?.cancel();
  }

  getPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      message(MessageModel.error(message: 'locationIsInactive'.tr));
    } else {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          message(MessageModel.error(message: 'locationIsInactive'.tr));
        }
      } else if (permission == LocationPermission.deniedForever) {
        message(MessageModel.error(message: 'locationIsInactive'.tr));
      } else {
        getStreamSubscription = Geolocator.getPositionStream().listen((event) {
          latitude.value = event.latitude.toString();
          longitude.value = event.longitude.toString();
        });
      }
    }
  }

  Future<void> getData() async {
    try {
      var financialPosition = await _customersViewModel
          .getCustomersAddress(customer.customerCode ?? 0);
      list.assignAll(financialPosition);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> chooseNavigation(CustomersAddressModel adresses) async {
    navigation(
      ChooseNavigationModel(
        openMaps: () async => await callMaps(adresses),
        openWaze: () async => await callWaze(adresses),
      ),
    );
  }

  callWaze(CustomersAddressModel adresses) async {
    var url =
        'waze://?q=${adresses.address},${adresses.numberAddress},${adresses.city}-${adresses.state}&ll=${latitude.value.toString()},%${latitude.value.toString()}';
    var fallbackUrl =
        'https://waze.com/ul?q=${adresses.address},${adresses.numberAddress},${adresses.city}-${adresses.state}&ll=${latitude.value.toString()},%${latitude.value.toString()}&navigate=yes';
    if (adresses.address != '' && adresses.address != null) {
      try {
        bool launched =
            await launch(url, forceSafariVC: false, forceWebView: false);
        if (!launched) {
          await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
        }
      } catch (e) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } else {
      message(MessageModel.error(message: 'pleaseFillInformation'.tr));
    }
  }

  callMaps(CustomersAddressModel adresses) async {
    var fallbackUrl =
        'https://www.google.com.br/maps/dir/${latitude.value},${longitude.value}/${adresses.address},+${adresses.numberAddress},+${adresses.city}+-+${adresses.state}';

    if (adresses.address != '' && adresses.address != null) {
      try {
        bool launched = await launch(fallbackUrl,
            forceWebView: false, forceSafariVC: false);
        if (!launched) {
          await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
        }
      } catch (e) {
        await launch(fallbackUrl, forceWebView: false, forceSafariVC: false);
      }
    } else {
      message(MessageModel.error(message: 'pleaseFillInformation'.tr));
    }
  }
}
