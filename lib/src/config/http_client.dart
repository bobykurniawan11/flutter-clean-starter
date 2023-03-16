import 'package:app/src/utils/api_constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  //set dio with interceptors
  Dio get dio => _dio;
  late Dio _dio;

  DioClient() {
    _dio = Dio();
    //base url
    _dio.options.baseUrl = ApiConstants.baseUrl;
    //set timeout
    _dio.options.connectTimeout = const Duration(milliseconds: 500);
    _dio.options.receiveDataWhenStatusError = true;

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError dioError, handler) {
      return handler.next(dioError);
    }));
  }
}
