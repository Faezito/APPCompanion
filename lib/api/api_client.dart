import 'package:appcompanion/services/auth_interceptor.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      // baseUrl: 'http://localhost:5130',
      baseUrl: 'https://localhost:44339',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static void init(){
    dio.interceptors.add(AuthInterceptor());
  }
}