import 'package:appcompanion/models/responses/usuario_response.dart';
import 'package:appcompanion/services/usuario_service.dart';
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

    bool carregando = true;

    late UsuarioResponse usuario;

    @override
    void initState() {
      super.initState();
      carregarUsuario();
    }

    Future<void> carregarUsuario() async {
      usuario = await UsuarioService().obterPorId(widget.usuarioId);
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
        await UsuarioService().atualizarUsuario(
          id: usuario.id,
          email: _emailController.text
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário atualizado com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar usuário: $e')),
        );
      }
    }
  }
}
