import 'package:appcompanion/models/responses/usuario_response.dart';

class LoginRequest {
   final String login;
   final String senha;

   LoginRequest({required this.login, required this.senha});

   Map<String, dynamic> toJson() {
     return {
       'login': login,
       'senha': senha,
     };
   }
}

class LoginResponse {
   final String token;
   final DateTime? expiration;
   final UsuarioResponse? usuario;

   LoginResponse({required this.token, required this.expiration, required this.usuario});

   factory LoginResponse.fromJson(Map<String, dynamic> json) {
     return LoginResponse(
       token: json['token'],
       expiration: json['expiration'] != null ? DateTime.parse(json['expiration']) : DateTime.now().add(Duration(hours: 3)),
       usuario: json['usuario'] != null ? UsuarioResponse.fromJson(json['usuario']) : null,
     );
   }
}