import 'package:appcompanion/api/api_client.dart';
import 'package:appcompanion/exceptions/app_exception.dart';
import 'package:appcompanion/models/requests/login.dart';
import 'package:dio/dio.dart';

abstract class IAcessoService {
  Future<LoginResponse> login(LoginRequest request);
  Future<void> logout();
  Future<void> recuperarSenha({required String email});
  Future<void> redefinirSenha({required String token, required String novaSenha});
}

class AcessoService implements IAcessoService {
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await ApiClient.dio.post(
        '/api/acesso/login',
        data: request.toJson(),
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
        throw AppException(e.response?.data["detail"] ?? "Erro inesperado.");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await ApiClient.dio.post('/api/acesso/logout');
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<void> recuperarSenha({required String email}) async {
    try {
      await ApiClient.dio.post(
        '/api/acesso/recuperar-senha',
        data: {'email': email},
      );
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<void> redefinirSenha({required String token, required String novaSenha}) async {
    try {
      await ApiClient.dio.post(
        '/api/acesso/redefinir-senha',
        data: {'token': token, 'novaSenha': novaSenha},
      );
    } on DioException {
      rethrow;
    }
  }
}