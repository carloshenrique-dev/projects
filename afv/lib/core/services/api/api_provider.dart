import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:up_afv/core/services/api/api_interceptors.dart';

class ApiProvider {
  final Dio dioInstance;
  ApiProvider({
    required Dio dio,
  }) : dioInstance = dio;

  Dio createDio() {
    Dio dio = dioInstance;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    dio.interceptors.addAll({
      ApiInterceptors(
          //dio: dio,
          ),
    });
    return dio;
  }

  Future<String> getToken() async {
    try {
      dioInstance.options.contentType = Headers.formUrlEncodedContentType;
      /*var credentialToken = await dioInstance.post(
        'https://192.168.0.198:44384/api/Token',
        data: {
          'client_id':
              '9b00742eb2ea879ac72d63e597fc7fbceb5aa9edacf17355816ab31e8dd37e5a',
          'client_secret':
              '230c44d523920af2ef2933100367d89ccdd02660a462655469fecf4456a7ac14',
          'module':
              'fec9abda33caf2439abb36bec2440158391ed40bc46ab5b205f88b4d916c14cf',
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      var credentialTokenDecoded = credentialToken.data['access_token'];*/
      var credentialTokenDecoded =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiOWIwMDc0MmViMmVhODc5YWM3MmQ2M2U1OTdmYzdmYmNlYjVhYTllZGFjZjE3MzU1ODE2YWIzMWU4ZGQzN2U1YSIsIlNlbmhhIjoiMjMwYzQ0ZDUyMzkyMGFmMmVmMjkzMzEwMDM2N2Q4OWNjZGQwMjY2MGE0NjI2NTU0NjlmZWNmNDQ1NmE3YWMxNCIsIk1vZHVsZSI6ImZlYzlhYmRhMzNjYWYyNDM5YWJiMzZiZWMyNDQwMTU4MzkxZWQ0MGJjNDZhYjViMjA1Zjg4YjRkOTE2YzE0Y2YiLCJleHAiOjE2NTEyMDEwODIsImlzcyI6InVwc29mdHdhcmUiLCJhdWQiOiJ1cHNvZnR3YXJlIn0.YYYq8dcdJjp9_jWumGnPBryqQsbtG3N01shnXfYbUcI';
      var token = await dioInstance.post(
        'http://192.168.56.1:5246/Token',
        data: {
          'client_id':
              '9b00742eb2ea879ac72d63e597fc7fbceb5aa9edacf17355816ab31e8dd37e5a',
          'client_secret':
              '230c44d523920af2ef2933100367d89ccdd02660a462655469fecf4456a7ac14',
          'module':
              'fec9abda33caf2439abb36bec2440158391ed40bc46ab5b205f88b4d916c14cf',
          'Client_Token': credentialTokenDecoded,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      var tokenDecoded = json.decode(token.data);
      dioInstance.options.headers['Authorization'] =
          'Bearer ${tokenDecoded['access_token']}';
      return 'Bearer ${tokenDecoded['access_token']}';
    } on DioError catch (e) {
      log(e.toString());
      return '';
    }
  }

  /*@override
  onInit() async {
    await getToken();
    super.onInit();
  }*/

  Future<Response> post({required String path, required dynamic data}) async {
    try {
      await getToken();
      dioInstance.options.contentType = 'application/json';
      var response = await dioInstance.post(
        path,
        data: data,
      );
      return response;
    } on DioError catch (e) {
      log('[Dio Helper - Post] Exception => ' + e.message);
      rethrow;
    }
  }

  Future<Response> get({required String path}) async {
    try {
      await getToken();
      return await dioInstance.get(path);
    } on DioError catch (e) {
      log('[Dio Helper - Get] Exception => ' + e.message);
      rethrow;
    }
  }

  Future<Response> put({required String path, required dynamic data}) async {
    try {
      return await dioInstance.put(path, data: data);
    } on DioError catch (e) {
      log('[Dio Helper - Put] Exception => ' + e.message);
      rethrow;
    }
  }
}
