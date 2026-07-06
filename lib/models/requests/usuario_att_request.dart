class UsuarioAtualizacaoRequest {
final int id;
final String email;
final int? perfil;

UsuarioAtualizacaoRequest({
  required this.id,
  required this.email, 
  this.perfil = 5,
});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'perfil': perfil
    };
  }

  @override
  String toString() {
    return 'UsuarioAtualizacaoRequest(id: $id, email: $email, perfil: $perfil)';
  }
}