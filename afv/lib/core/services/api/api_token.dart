import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class ApiToken {
  final Dio _dio;
  ApiToken({required Dio dio}) : _dio = dio;

  Future<String> getToken() async {
    try {
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      var credentialToken = await _dio
          .post(
            'https://54.221.232.177/api/Token',
            data: {
              'client_id':
                  '9b00742eb2ea879ac72d63e597fc7fbceb5aa9edacf17355816ab31e8dd37e5a',
              'client_secret':
                  '230c44d523920af2ef2933100367d89ccdd02660a462655469fecf4456a7ac14',
              'module':
                  'fec9abda33caf2439abb36bec2440158391ed40bc46ab5b205f88b4d916c14cf',
            },
            options: Options(contentType: Headers.formUrlEncodedContentType),
          )
          .catchError((onError) {});
      var credentialTokenDecoded = json.decode(credentialToken.data);
      var token = await _dio.post(
        'https://54.221.232.177/api/Token',
        data: {
          'client_id':
              '9b00742eb2ea879ac72d63e597fc7fbceb5aa9edacf17355816ab31e8dd37e5a',
          'client_secret':
              '230c44d523920af2ef2933100367d89ccdd02660a462655469fecf4456a7ac14',
          'module':
              'fec9abda33caf2439abb36bec2440158391ed40bc46ab5b205f88b4d916c14cf',
          'Client_Token': credentialTokenDecoded['access_token'],
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      var tokenDecoded = json.decode(token.data);
      return tokenDecoded['access_token'];
    } on DioError catch (e) {
      log(e.toString());
      return 'error';
    }
  }
}
