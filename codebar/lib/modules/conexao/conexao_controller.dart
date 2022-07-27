import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:up_codebar/app/core/services/storage_services.dart';
import 'package:up_codebar/app/ui/messages/messages_mixin.dart';

class ConexaoController extends GetxController with MessagesMixin {
  final Connectivity _connectivity;
  final Storage _storage;
  final message = Rxn<MessageModel>();
  final idCliente = ''.obs;
  final isLogged = false.obs;
  final timer = '0'.obs;

  ConexaoController({
    required Connectivity connectivity,
    required Storage storage,
  })  : _connectivity = connectivity,
        _storage = storage;

  @override
  Future<void> onInit() async {
    super.onInit();
    messageListener(message);
    await checkConnectivity();
    recuperaConfiguracoes();
    streamConexao();
  }

  void streamConexao() {
    _connectivity.onConnectivityChanged.listen((conexao) async {
      if (conexao == ConnectivityResult.none) {
        Get.toNamed('/conexao');
      } else if ((Get.previousRoute == '' || Get.previousRoute == '/splash') &&
          isLogged.value &&
          idCliente.isNotEmpty) {
        Get.offAllNamed('/login');
      } else if ((Get.previousRoute == '' || Get.previousRoute == '/splash') &&
          !isLogged.value &&
          idCliente.isNotEmpty) {
        Get.offAllNamed('/login');
      } else if ((Get.previousRoute == '' || Get.previousRoute == '/splash') &&
          !isLogged.value &&
          idCliente.isEmpty) {
        Get.offAllNamed('/auth');
      } else {
        Get.back();
      }
    });
  }

  void recuperaConfiguracoes() async {
    try {
      isLogged.value = await _storage.checaDados();
      idCliente.value = await _storage.recuperaClientID();

      var tempoTimer = await _storage.genericReadStorage(key: 'tempo');
      if (tempoTimer != '') {
        timer.value = tempoTimer;
      } else {
        timer.value = '0';
      }
    } catch (e) {
      message(MessageModel.error(message: 'errorReadConfigsConnection'.tr));
    }
  }

  Future<void> checkConnectivity() async {
    try {
      var conexao = await _connectivity.checkConnectivity();
      if (conexao == ConnectivityResult.none) {
        Get.toNamed('/conexao');
      } else {
        Get.back();
      }
    } catch (e) {
      message(MessageModel.error(message: 'conexaoPageConexao'.tr));
    }
  }

  void connectionTest() async {
    var resultado = await (_connectivity.checkConnectivity());
    if (resultado != ConnectivityResult.none) {
      Get.back();
    } else {
      message(MessageModel.error(message: 'conexaoPageConexao'.tr));
    }
  }
}
