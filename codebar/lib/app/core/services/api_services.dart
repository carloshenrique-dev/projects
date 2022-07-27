import 'package:dio/dio.dart';
import 'storage_services.dart';

class ApiServices {
  CredencialAPI credencialAPI = CredencialAPI();
  final Storage _storage;
  final Dio dio = Dio();

  ApiServices({required Storage storage}) : _storage = storage;

  Future<String> requestToken() async {
    try {
      String idCliente = await _storage.recuperaClientID();
      if (idCliente == '') {
        await _storage.gravaClientID(credencialAPI.clientID!);
        var response = await dio.post(
            'http://upapi.cloudupsoftware.com/UpApi/v6/api/token',
            data: {'ID_Cliente': idCliente, 'homolog': false});
        return response.data['token'];
      } else {
        var response = await dio.post(
            'http://upapi.cloudupsoftware.com/UpApi/v6/api/token',
            data: {'ID_Cliente': idCliente, 'homolog': false});
        return response.data['token'];
      }
    } on DioError {
      return '';
    }
  }

  Future genericPost({required Map map, required String endPoint}) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer ' + await requestToken();
      var response = await dio.post(
          'http://upapi.cloudupsoftware.com/UpApi/v6/api/' + endPoint,
          data: map);
      return response.data;
    } on DioError catch (e) {
      return e.response?.data;
    } catch (e) {
      return (e);
    }
  }

  Future genericPut({required Map map, required String endPoint}) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer ' + await requestToken();
      var response = await dio.put(
          'http://upapi.cloudupsoftware.com/UpApi/v6/api/' + endPoint,
          data: map);
      return response.data;
    } on DioError catch (e) {
      return e;
    } catch (e) {
      return (e);
    }
  }

  Future genericGet({required String endPoint}) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer ' + await requestToken();
      var response = await dio
          .get('http://upapi.cloudupsoftware.com/UpApi/v6/api/' + endPoint);
      return response.data;
    } on DioError catch (e) {
      return e;
    } catch (e) {
      return (e);
    }
  }
}

class CredencialAPI {
  final String? clientID;

  CredencialAPI({this.clientID});
}
