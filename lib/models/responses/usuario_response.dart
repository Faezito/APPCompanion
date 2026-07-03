class UsuarioResponse {
final int id;
final String nomeCompleto;
final String nomeUsuario;
final String email;
final String generoTxt;
final DateTime dataNascimento;

UsuarioResponse({
  required this.id, 
  required this.nomeCompleto, 
  required this.nomeUsuario, 
  required this.email, 
  required this.generoTxt,
  required this.dataNascimento
  });

  factory UsuarioResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioResponse(
      id: json['id'],
      nomeCompleto: json['nomeCompleto'],
      nomeUsuario: json['nomeUsuario'],
      email: json['email'],
      generoTxt: json['genero'],
      dataNascimento: DateTime.parse(json['dataNascimento']),
    );
  }
}