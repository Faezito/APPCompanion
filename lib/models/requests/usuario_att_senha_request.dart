class UsuarioAtualizacaoSenhaRequest {
final int usuarioId;
final String novaSenha;
final String senhaAtual;

UsuarioAtualizacaoSenhaRequest({
  required this.usuarioId,
  required this.novaSenha,
  required this.senhaAtual,
});

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
      'novaSenha': novaSenha,
      'senhaAtual': senhaAtual,
    };
  }

  @override
  String toString() {
    return 'UsuarioAtualizacaoSenhaRequest(usuarioId: $usuarioId, novaSenha: $novaSenha, senhaAtual: $senhaAtual)';
  }
}