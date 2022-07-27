import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:up_template/controllers/crypto.dart';
import 'package:up_template/models/telefone_model.dart';
import 'package:upentregas/app/modules/otp/otp_view.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/shared/ui/loader/loader_mixin.dart';
import 'package:upentregas/app/shared/ui/messages/messages_mixin.dart';

class PhoneController extends GetxController with LoaderMixin, MessagesMixin {
  var phoneNo = ''.obs;
  var id = ''.obs;
  var isValid = false.obs;
  final loading = false.obs;
  final message = Rxn<MessageModel>();

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  validaTelefone() async {
    loading(true);
    try {
      if (isValid.value == true) {
        bool retorno = await validation(phoneNo.value,
            'AuthValidation/validation', 'invalidphone'.tr, 'ID: $id');
        if (retorno) {
          loading(false);
          Get.to(() => OTPView(
                mobileNumber: phoneNo.value,
              ));
        } else {
          loading(false);
          message(MessageModel.error(message: 'verifyphonenumber'.tr));
        }
      } else {
        loading(false);
        message(MessageModel.error(message: 'verifyphonenumber'.tr));
      }
    } catch (e) {
      loading(false);
      message(MessageModel.error(message: 'verifyphonenumber'.tr));
    }
  }

  Future<bool> validation(
      String phoneNo, String telurl, String texto, String texto2) async {
    try {
      var random = await content.randomNumeric();
      var keyCript = await Crypto().crypto(random, 'E', 'U');
      var valido = await gravaChave(keyCript, phoneNo);

      if (valido != null) {
        Map<String, dynamic> tel = {
          'COD_SISTEMA': 12,
          'TELEFONE': phoneNo,
          'PHONE_KEY': '$valido'
        };

        final resp = await content.api.postGeneric(telurl, tel);
        final json = jsonDecode(resp.response!);

        json.forEach(
          (element) async {
            final validacao = Telefone.fromJson(element);
            telefoneValidation(validacao, texto, texto2);
          },
        );
        return true;
      } else {
        message(MessageModel.error(
            message: '${'numberLicense'.tr} $phoneNo ${'linkedDevice'.tr}'));
        return false;
      }
    } catch (e) {
      message(MessageModel.error(message: 'phoneValidationError'.tr));
      return false;
    }
  }

  gravaChave(String keyCript, String phoneNo) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final QuerySnapshot result = await Future.value(content.firebaseContent.db!
        .collection('Validacao')
        .where('telefone', isEqualTo: phoneNo)
        .limit(1)
        .get());

    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 1) {
      var result = await content.firebaseContent.db!
          .collection('Validacao')
          .where('telefone', isEqualTo: phoneNo)
          .where('device_id', isEqualTo: androidInfo.id)
          .get();
      for (var res in result.docs) {
        return res.data()['phone_key'];
      }
      if (result.docs.isNotEmpty) {
        var teste = result.docs.first['phone_key'];
        return teste;
      } else {
        return null;
      }
    } else {
      await content.firebaseContent.db!.collection('Validacao').doc().set({
        'phone_key': keyCript,
        'telefone': phoneNo,
        'device_id': androidInfo.id
      });
      return keyCript;
    }
  }

  Future<bool> telefoneValidation(
      Telefone validacao, String texto, String texto2) async {
    String? phoneNo = validacao.telefone;
    int? situacao = validacao.situacao;
    String? situacaoDescricao = validacao.situacaoDescricao;

    try {
      if (phoneNo == phoneNo && situacao == 0 && situacaoDescricao == 'ATIVO') {
        return true;
      } else if (phoneNo == phoneNo &&
          situacao == 1 &&
          situacaoDescricao == 'INATIVO') {
        message(MessageModel.error(
            message: '$texto\n$situacaoDescricao\n$texto2\n$phoneNo'));
        return false;
      } else {
        message(MessageModel.error(
            message: '$texto\n$situacaoDescricao\n$texto2\n$phoneNo'));
        return false;
      }
    } catch (e) {
      //print(e);
      //message(MessageModel.error(message: 'phoneValidationError'.tr));
      return false;
    }
  }
}
