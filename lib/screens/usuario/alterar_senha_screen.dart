import 'package:appcompanion/services/usuario_service.dart';
import 'package:flutter/material.dart';

class AlterarSenhaScreen extends StatefulWidget {
   final int usuarioId;

   const AlterarSenhaScreen({super.key, required this.usuarioId});

   @override
   State<AlterarSenhaScreen> createState() => _AlterarSenhaScreenState();
 }
 
 class _AlterarSenhaScreenState extends State<AlterarSenhaScreen> {
    final _formKey = GlobalKey<FormState>();
    final _novaSenhaController = TextEditingController();
    final _senhaAtualController = TextEditingController();

    bool carregando = false;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text("Alterar Senha")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _senhaAtualController,
                  decoration: const InputDecoration(labelText: "Senha atual"),
                  obscureText: true,
                ),

                TextFormField(
                  controller: _novaSenhaController,
                  decoration: const InputDecoration(labelText: "Nova senha"),
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: carregando ? null : salvar,
                  child: carregando
                      ? const CircularProgressIndicator()
                      : const Text("Alterar Senha"),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Future<void> salvar() async {
      setState(() => carregando = true);

      try {
        await UsuarioService().atualizarSenha(
          usuarioId: widget.usuarioId,
          novaSenha: _novaSenhaController.text,
          senhaAtual: _senhaAtualController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Senha alterada com sucesso!")),
        );
      } catch (e) {
        print("Erro ao alterar senha: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro ao alterar senha.", style: TextStyle(color: Colors.red))),
        );
      } finally {
        setState(() {
          carregando = false;
        });
      }
    }

    @override
    void dispose() {
      _novaSenhaController.dispose();
      _senhaAtualController.dispose();
      super.dispose();
    }
 }