import 'package:appcompanion/api/api_client.dart';
import 'package:appcompanion/models/requests/usuario_att_senha_request.dart';
import 'package:appcompanion/models/requests/usuario_cadastro.dart';
import 'package:appcompanion/models/responses/usuario_response.dart';
import 'package:dio/dio.dart';

class UsuarioService {
  Future<UsuarioResponse> obterPorId(int id) async {
    try{
      Response res = await ApiClient.dio.get(
        '/api/usuario/$id'
      );

        return UsuarioResponse.fromJson(res.data);
    } on DioException {
      rethrow;
    }
  }

  Future<void> cadastrarUsuario({
    required String nomeCompleto,
    required String nomeUsuario,
    required String email,
    required String senha,
    required String genero,
    required DateTime dataNascimento,
  }) async {
    try {
      final usuarioCadastro = UsuarioCadastro(
        nomeCompleto: nomeCompleto,
        nomeUsuario: nomeUsuario,
        senha: senha,
        email: email,
        genero: genero,
        dataNascimento: dataNascimento,
      ); 

      print('UsuarioCadastro: ${usuarioCadastro.toJson()}');
      Response res = await ApiClient.dio.post(
        '/api/usuario/cadastro',
        data: usuarioCadastro.toJson(),
      );
    } on DioException {
      rethrow;
    }
  }

  Future<void> atualizarUsuario({
    required int id,
    required String email
  }) async {
    try {
      final usuarioAtualizado = {
        'id': id,
        'email': email
      };

      String endpoint = '/api/usuario/atualizar-usuario';

      Response res = await ApiClient.dio.put(
        endpoint,
        data: usuarioAtualizado,
      );
    } on DioException {
      rethrow;
    }
  }

  Future<void> atualizarSenha({
    required int usuarioId,
    required String novaSenha,
    required String senhaAtual
  }) async {
    try {
      final usuarioAtualizado = UsuarioAtualizacaoSenhaRequest(
        usuarioId: usuarioId,
        novaSenha: novaSenha,
        senhaAtual: senhaAtual
      );

      String endpoint = '/api/usuario/atualizar-senha';
      print('UsuarioAtualizacaoSenhaRequest: ${usuarioAtualizado.toString()}');
      Response res = await ApiClient.dio.put(
        endpoint,
        data: usuarioAtualizado.toJson(),
      );
    } on DioException {
      rethrow;
    }
  }

  Future<List<UsuarioResponse>> listarUsuarios() async {
    try {
      Response res = await ApiClient.dio.get(
        '/api/usuario/listar'
      );

      List<dynamic> data = res.data;
      return data.map((json) => UsuarioResponse.fromJson(json)).toList();
    } on DioException {
      rethrow;
    }
  }
}