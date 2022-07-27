import 'package:dio/dio.dart';

class ApiInterceptors extends InterceptorsWrapper {
  /*final Dio _dio;
  ApiInterceptors({
    required Dio dio,
  }) : _dio = dio;

  /*@override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

 */

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //if(options.headers)
    super.onRequest(options, handler);
  }*/
}
