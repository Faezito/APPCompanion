import 'package:appcompanion/api/api_client.dart';
import 'package:appcompanion/exceptions/app_exception.dart';
import 'package:appcompanion/models/requests/usuario_att_request.dart';
import 'package:appcompanion/models/requests/usuario_att_senha_request.dart';
import 'package:appcompanion/models/requests/usuario_cadastro.dart';
import 'package:appcompanion/models/responses/usuario_response.dart';
import 'package:dio/dio.dart';

abstract class IUsuarioService 
{
  Future<UsuarioResponse> obterPorId(int id);
  Future<void> cadastrarUsuario({required UsuarioCadastro usuarioCadastro});
  Future<void> atualizarUsuario({required UsuarioAtualizacaoRequest usuarioEdicaoRequest});
  Future<void> atualizarSenha({required UsuarioAtualizacaoSenhaRequest usuarioAtualizacaoSenhaRequest});
  Future<List<UsuarioResponse>> listarUsuarios();
  Future<void> excluirUsuario(int id);
}

class UsuarioService implements IUsuarioService {
  @override
  Future<UsuarioResponse> obterPorId(int id) async 
  {
    try{
      Response res = await ApiClient.dio.get(
        '/api/usuario/$id'
      );

        return UsuarioResponse.fromJson(res.data);
    } on DioException catch (e) {
        throw AppException(e.response?.data["detail"] ?? "Erro inesperado.");
    }
  }

  @override
  Future<void> cadastrarUsuario({required UsuarioCadastro usuarioCadastro}) async 
  {
    try {
      await ApiClient.dio.post(
        '/api/usuario/cadastro',
        data: usuarioCadastro.toJson(),
        );
    } on DioException catch (e) {
        throw AppException(e.response?.data["detail"] ?? "Erro inesperado.");
    }
  }

  @override
  Future<void> atualizarUsuario({required UsuarioAtualizacaoRequest usuarioEdicaoRequest}) async {
    try {
        await ApiClient.dio.put(
          '/api/usuario/atualizar-usuario',
          data: usuarioEdicaoRequest.toJson(),
          );
    } on DioException catch (e) {
        throw AppException(e.response?.data["detail"] ?? "Erro inesperado.");
    }
  }

  @override
  Future<void> atualizarSenha({ required UsuarioAtualizacaoSenhaRequest usuarioAtualizacaoSenhaRequest }) async
  {
    try {
        await ApiClient.dio.put(
          '/api/usuario/atualizar-senha',
          data: usuarioAtualizacaoSenhaRequest.toJson(),
        );
    } on DioException catch (e) {
        throw AppException(e.response?.data["detail"] ?? "Erro inesperado.");
    }
  }

  @override
  Future<List<UsuarioResponse>> listarUsuarios() async 
  {
    try {
      Response res = await ApiClient.dio.get(
        '/api/usuario/listar'
      );

      List<dynamic> data = res.data;
      return data.map((json) => UsuarioResponse.fromJson(json)).toList();
    } on DioException catch (e) {
        throw AppException(e.response?.data["detail"] ?? "Erro inesperado.");
    }
  }

  @override
  Future<void> excluirUsuario(int id) async {
    try {
        await ApiClient.dio.delete(
          '/api/usuario/excluir/$id',
        );
    } on DioException catch (e) {
        throw AppException(e.response?.data["detail"] ?? "Erro inesperado.");
    }
  }
}