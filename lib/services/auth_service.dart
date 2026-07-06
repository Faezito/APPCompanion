import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const _tokenKey = 'token';
  static const _expirationKey = 'expiration';
  static const _perfilKey = 'perfil';

  /// SALVAR LOGIN
  static Future<void> salvarSessao({
    required String token,
    required DateTime expiration,
    required int perfil
  }) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(
      key: _expirationKey,
      value: expiration.toIso8601String(),
    );
    await _storage.write(key: _perfilKey, value: perfil.toString());
  }

  /// PEGAR TOKEN
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Pegar Perfil
  static Future<int?> obterPerfil() async {
    final value = await _storage.read(key: _perfilKey);
    if(value == null) return null;
    return int.tryParse(value); 
  }

  /// PEGAR EXPIRAÇÃO
  static Future<DateTime?> getExpiration() async {
    final value = await _storage.read(key: _expirationKey);
    if (value == null) return null;
    return DateTime.tryParse(value);
  }

  /// VERIFICAR SE ESTÁ LOGADO
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    final expiration = await getExpiration();

    if (token == null || expiration == null) return false;

    return DateTime.now().isBefore(expiration);
  }

  /// LOGOUT
  static Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _expirationKey);
  }

  // Confere se é admin
  static Future<bool> isAdmin() async => await obterPerfil() == 1;
}