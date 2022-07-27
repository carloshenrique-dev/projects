import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class Storage {
  final GetStorage _getStorage;
  Storage({
    required GetStorage getStorage,
  }) : _getStorage = getStorage;

  void expireDate() {
    var data = DateTime.now();
    _getStorage.write(
        'expireDate',
        DateFormat('yyyy-MM-dd kk:mm')
            .format(data.add(const Duration(days: 5))));
  }

  bool verifyExpirationDate() {
    bool isExpired = false;
    if (_getStorage.read('expireDate') != null &&
        _getStorage.read('expireDate') != '') {
      DateTime data = DateTime.parse(_getStorage.read('expireDate'));
      isExpired = data.isBefore(DateTime.parse(
          DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now())));
      if (isExpired == true) {
        exit(0);
      }
    }
    return isExpired;
  }

  Future<void> salvaDados(
      {required String login, required String senha}) async {
    _getStorage.write('login', login);
    _getStorage.write('senha', senha);
  }

  Future<bool> checaDados() async {
    if (_getStorage.read('login') != null &&
        _getStorage.read('senha') != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> retornaUser() async {
    if (_getStorage.read('login') != null && _getStorage.read('login') != '') {
      return _getStorage.read('login');
    } else {
      return '';
    }
  }

  Future<bool> gravaClientID(String clientID) async {
    try {
      _getStorage.write('clientID', clientID);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<String> recuperaClientID() async {
    if (_getStorage.read('clientID') != null &&
        _getStorage.read('clientID') != '') {
      return _getStorage.read('clientID');
    } else {
      return '';
    }
  }

  Future<bool> genericStorage(
      {required String key, required dynamic value}) async {
    try {
      _getStorage.write(key, value);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<dynamic> genericReadStorage({required String key}) async {
    if (_getStorage.read(key) != null && _getStorage.read(key) != '') {
      return _getStorage.read(key);
    } else {
      return '';
    }
  }
}
