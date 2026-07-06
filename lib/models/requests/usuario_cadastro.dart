class UsuarioCadastro {
final String nomeCompleto;
final String nomeUsuario;
final String email;
final String genero;
final DateTime dataNascimento;
final String senha;
final int? perfil;

UsuarioCadastro({
  required this.nomeCompleto, 
  required this.nomeUsuario, 
  required this.email, 
  required this.genero,
  required this.dataNascimento,
  required this.senha, 
  this.perfil = 5
});

  Map<String, dynamic> toJson() {
    return {
      'nomeCompleto': nomeCompleto,
      'nomeUsuario': nomeUsuario,
      'email': email,
      'genero': genero,
      'dataNascimento': dataNascimento.toIso8601String(),
      'senha': senha,
      'perfil': perfil
    };
  }

  @override
  String toString() {
    return 'UsuarioCadastro(nomeCompleto: $nomeCompleto, nomeUsuario: $nomeUsuario, email: $email, genero: $genero, dataNascimento: $dataNascimento, senha: $senha, perfil: $perfil)';
  }
}