import 'package:appcompanion/core/di/service_locator.dart';
import 'package:dio/dio.dart';
import '../services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final _auth = getIt<IAuthService>();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {

    final token = _auth.obterToken;

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }
}