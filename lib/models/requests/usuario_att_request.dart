class UsuarioAtualizacaoRequest {
final int id;
final String email;

UsuarioAtualizacaoRequest({
  required this.id,
  required this.email,
});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'UsuarioAtualizacaoRequest(id: $id, email: $email)';
  }
}