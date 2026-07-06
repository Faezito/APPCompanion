import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/models/requests/usuario_att_request.dart';
import 'package:appcompanion/models/responses/usuario_response.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:appcompanion/services/usuario_service.dart';
import 'package:appcompanion/widgets/dropdowns/perfil_dropdown.dart';
import 'package:appcompanion/widgets/snackbar/snackbar_service.dart';
import 'package:flutter/material.dart';

class EditarUsuarioScreen extends StatefulWidget {
   final int usuarioId;

   const EditarUsuarioScreen({super.key, required this.usuarioId});

   @override
   State<EditarUsuarioScreen> createState() => _EditarUsuarioScreenState();
 }

 class _EditarUsuarioScreenState extends State<EditarUsuarioScreen> {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    bool _isAdmin = false;
    int? _perfilSelecionado = 5;

    final usuarioService = getIt<IUsuarioService>();

    bool carregando = true;

    late UsuarioResponse usuario;

    @override
    void initState() {
      super.initState();
      _carregarUsuario();
      _carregarPermissoes();
    }

    Future<void> _carregarUsuario() async {
      usuario = await usuarioService.obterPorId(widget.usuarioId);
      _emailController.text = usuario.email;

      setState(() {
        carregando = false;
      });
    }
        
  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Editar Usuário")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Usuário: ${usuario.nomeUsuario}"),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),

              const SizedBox(height: 20),
              if(_isAdmin)
                PerfilDropdown(
                  value: _perfilSelecionado, 
                    onChanged: (value) {
                            setState(() {
                              _perfilSelecionado = value;
                            });
                      }
                  ),
              ElevatedButton(
                onPressed: salvar,
                child: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> salvar() async {
    if (_formKey.currentState!.validate()) {
      try {
        await usuarioService.atualizarUsuario(
          usuarioEdicaoRequest: UsuarioAtualizacaoRequest(
            id: usuario.id,
            email: _emailController.text
          )
        );

        SnackbarService.snackSucesso('Usuário atualizado com sucesso!');
      } catch (e) {
        SnackbarService.snackErro('Erro ao atualizar usuário: $e');
      }
    }
  }
  
   Future<void> _carregarPermissoes() async {
      _isAdmin = await AuthService.isAdmin();
      if(!mounted) return;
      setState(() { });
   }
}