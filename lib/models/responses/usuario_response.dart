class UsuarioResponse {
final int id;
final String nomeCompleto;
final String nomeUsuario;
final String email;
final String generoTxt;
final DateTime dataNascimento;
final int perfil;

UsuarioResponse({
  required this.id, 
  required this.nomeCompleto, 
  required this.nomeUsuario, 
  required this.email, 
  required this.generoTxt,
  required this.dataNascimento, 
  required this.perfil
  });

  String get perfilTxt => switch (perfil){
    1 => "Admin",
    5 => "Usuario",
    _ => "Desconhecido"
  };

  bool get isAdmin => perfil == 1;

  factory UsuarioResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioResponse(
      id: json['id'],
      nomeCompleto: json['nomeCompleto'],
      nomeUsuario: json['nomeUsuario'],
      email: json['email'],
      generoTxt: json['genero'],
      dataNascimento: DateTime.parse(json['dataNascimento']), 
      perfil: json['perfil'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nomeCompleto": nomeCompleto,
      "nomeUsuario": nomeUsuario,
      "email": email,
      "genero": generoTxt,
      "dataNascimento": dataNascimento.toIso8601String(),
      "perfil": perfil,
    };
  }
}