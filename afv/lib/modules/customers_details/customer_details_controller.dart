import 'dart:developer';
import 'package:get/get.dart';
import 'package:up_afv/application/themes/ui/messages/messages_mixin.dart';
import 'package:up_afv/core/models/customers/customers_address_model.dart';
import 'package:up_afv/core/models/customers/customers_model.dart';
import 'package:up_afv/core/view_models/customers/customers_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailsController extends GetxController with MessagesMixin {
  var cli = CustomersModel();
  final message = Rxn<MessageModel>();
  final addressModel = <CustomersAddressModel>[].obs;
  final CustomersViewModel _customersViewModel;

  CustomerDetailsController({
    required CustomersViewModel customersViewModel,
  }) : _customersViewModel = customersViewModel;

  @override
  void onInit() async {
    super.onInit();
    cli = Get.arguments;
    messageListener(message);
    await getCustomerAddress();
  }

  getCustomerAddress() async {
    try {
      var address =
          await _customersViewModel.getCustomersAddress(cli.customerCode!);
      addressModel.assignAll(address);
    } catch (e) {
      log(e.toString());
    }
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;
    String greeting = '';

    if (timeNow <= 12) {
      greeting = 'morning'.tr;
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      greeting = 'afternoon'.tr;
    } else if ((timeNow > 16) && (timeNow < 20)) {
      greeting = 'evening'.tr;
    } else {
      greeting = 'night'.tr;
    }
    return greeting;
  }

  callEmail() async {
    if (cli.mail != '' && cli.mail != null) {
      String sendEmail =
          'mailto:${cli.mail}?subject=This is Subject Title&body=This is Body of Email';
      try {
        bool launched = await launch(sendEmail);
        if (!launched) {
          await launch(sendEmail);
        }
      } catch (e) {
        await launch(sendEmail);
      }
    } else {
      message(MessageModel.error(message: 'pleaseFillInformation'.tr));
    }
  }

  callPhone() async {
    String formatedPhone = '';
    if (cli.phones != null && cli.phones != '') {
      formatedPhone = cli.phones!.replaceAll(RegExp(r'[^\w\s]+'), '');
      var link = 'tel://$formatedPhone';
      try {
        bool launched = await launch(link);
        if (!launched) {
          await launch(link);
        }
      } catch (e) {
        await launch(link);
      }
    } else {
      message(MessageModel.error(message: 'pleaseFillInformation'.tr));
    }
  }

  callWhats() async {
    String formatedPhone = '';
    if (cli.phones != null && cli.phones != '') {
      formatedPhone = cli.phones!.replaceAll(RegExp(r'[^\w\s]+'), '');
      var link =
          'https://wa.me/55$formatedPhone?text=${greetingMessage()}, ${'weGoing'.tr} 😁';
      try {
        bool launched =
            await launch(link, forceSafariVC: false, forceWebView: false);
        if (!launched) {
          await launch(link, forceSafariVC: false, forceWebView: false);
        }
      } catch (e) {
        await launch(link, forceSafariVC: false, forceWebView: false);
      }
    } else {
      message(MessageModel.error(message: 'pleaseFillInformation'.tr));
    }
  }
}
