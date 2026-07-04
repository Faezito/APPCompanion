  import 'package:appcompanion/models/responses/usuario_response.dart';
  import 'package:appcompanion/screens/usuario/alterar_senha_screen.dart';
  import 'package:appcompanion/screens/usuario/cadastro_screen.dart';
  import 'package:appcompanion/screens/usuario/editar_screen.dart';
  import 'package:appcompanion/services/usuario_service.dart';
  import 'package:appcompanion/widgets/dialogs/delete_confirm_dialog.dart';
  import 'package:flutter/material.dart';

  class ListaUsuariosScreen extends StatefulWidget {
    final IUsuarioService usuarioService;

    const ListaUsuariosScreen({super.key, required this.usuarioService});

    @override
    State<ListaUsuariosScreen> createState() => _ListaUsuariosScreenState();
  }

  class _ListaUsuariosScreenState extends State<ListaUsuariosScreen> {
    late Future<List<UsuarioResponse>> usuariosFuture;

    @override
    void initState() {
      super.initState();
      usuariosFuture = widget.usuarioService.listarUsuarios();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Usuários"), 
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              color: Colors.blue,
              tooltip: "Cadastrar novo usuário",
              onPressed: () async {
                final res = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CadastroScreen(),
                  ),
                );

                if(res == true)
                {
                  setState(() {
                    usuariosFuture = widget.usuarioService.listarUsuarios();
                  });
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: "Atualizar lista de usuários",
              onPressed: () {
                setState(() {
                  usuariosFuture = widget.usuarioService.listarUsuarios();
                });
              },
            ),
          ]
          ),
        body: FutureBuilder<List<UsuarioResponse>>(
          future: usuariosFuture,
          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final usuarios = snapshot.data!;

            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];

                return Card(
                  child: ListTile(
                    title: Text(usuario.nomeUsuario),
                    subtitle: Text(usuario.email),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditarUsuarioScreen(usuarioId: usuario.id, usuarioService: widget.usuarioService),
                              ),
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.lock),
                          tooltip: "Alterar senha",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AlterarSenhaScreen(usuarioId: usuario.id, usuarioService: widget.usuarioService),
                              ),
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: "Excluir usuário",
                          color: Colors.red,
                          onPressed: () async {
                            final confirmou = await showDeleteConfirmDialog(
                              context,
                              title: "Confirmação",
                              content: "Deseja realmente excluir este usuário?",
                            );

                            if (confirmou == true) 
                            {
                              await widget.usuarioService.excluirUsuario(usuario.id);
                              setState(() {
                                usuariosFuture = widget.usuarioService.listarUsuarios();
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Usuário excluído com sucesso!")),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }
  }