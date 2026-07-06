import 'dart:convert';

import 'package:appcompanion/models/responses/usuario_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class IAuthService {
  Future<void> salvarSessao({required String token, required DateTime expiration, required int perfil, required UsuarioResponse usuario});
  Future<DateTime?> getExpiration();
  bool isLoggedIn();
  Future<void> logout();
  Future<void> restaurarSessao();
  UsuarioResponse? get usuario;
  bool get isAdmin;
  String? get obterToken;
}

class AuthService implements IAuthService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const _tokenKey = 'token';
  static const _expirationKey = 'expiration';
  static const _usuarioKey = 'usuario';
  UsuarioResponse? _usuario;
  String? _token;
  DateTime? _expiration;

  @override
  Future<void> salvarSessao({
    required String token,
    required DateTime expiration,
    required int perfil,
    required UsuarioResponse usuario
  }) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(
      key: _expirationKey,
      value: expiration.toIso8601String(),
    );
    await _storage.write(key: _usuarioKey, value: jsonEncode(usuario.toJson()));
    _usuario = usuario;
    _token = token;
    _expiration = expiration;
  }

  @override
  Future<DateTime?> getExpiration() async => _expiration;

  @override
  bool isLoggedIn() {
    if (_token == null || _expiration == null) {
      return false;
    }

    return DateTime.now().isBefore(_expiration!);
  }

  @override
  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _expirationKey);
    _token = null;
    _expiration = null;
    _usuario = null;
    await _storage.delete(key: _usuarioKey);
  }

  @override
  Future<void> restaurarSessao() async {
    _token = await _storage.read(key: _tokenKey);

    final expirationString = await _storage.read(key: _expirationKey);

    if (expirationString != null) {
      _expiration = DateTime.tryParse(expirationString);
    }

    final usuarioJson = await _storage.read(key: _usuarioKey);

    if (usuarioJson != null) {
      _usuario = UsuarioResponse.fromJson(
        jsonDecode(usuarioJson),
      );
    }
  }

  @override
  String? get obterToken => _token;
  
  @override
  bool get isAdmin => _usuario?.perfil == 1;

  @override
  UsuarioResponse? get usuario => _usuario;

}