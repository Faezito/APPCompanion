  import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/models/responses/usuario_response.dart';
import 'package:appcompanion/screens/auth/login_screen.dart';
  import 'package:appcompanion/screens/usuario/alterar_senha_screen.dart';
  import 'package:appcompanion/screens/usuario/cadastro_screen.dart';
  import 'package:appcompanion/screens/usuario/editar_screen.dart';
import 'package:appcompanion/services/auth_service.dart';
  import 'package:appcompanion/services/usuario_service.dart';
  import 'package:appcompanion/widgets/dialogs/delete_confirm_dialog.dart';
  import 'package:flutter/material.dart';

  class ListaUsuariosScreen extends StatefulWidget {

    const ListaUsuariosScreen({super.key});

    @override
    State<ListaUsuariosScreen> createState() => _ListaUsuariosScreenState();
  }

  class _ListaUsuariosScreenState extends State<ListaUsuariosScreen> {
    late Future<List<UsuarioResponse>> usuariosFuture;
    final IUsuarioService _usuarioService = getIt<IUsuarioService>();
    final IAuthService _auth = getIt<IAuthService>();

    @override
    void initState() {
      super.initState();
      usuariosFuture = _usuarioService.listarUsuarios();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Usuários - ${_auth.usuario?.nomeCompleto ?? ''}"), 
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
                    usuariosFuture = _usuarioService.listarUsuarios();
                  });
                }
              },
            ),

            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: "Atualizar lista de usuários",
              onPressed: () {
                setState(() {
                  usuariosFuture = _usuarioService.listarUsuarios();
                });
              },
            ),
            
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: "Sair",
              onPressed: () async {
               await _auth.logout();
               if(!mounted) return;

               Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false
               );
              }
            )
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
                                builder: (_) => EditarUsuarioScreen(usuarioId: usuario.id),
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
                                builder: (_) => AlterarSenhaScreen(usuarioId: usuario.id),
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
                              await _usuarioService.excluirUsuario(usuario.id);
                              setState(() {
                                usuariosFuture = _usuarioService.listarUsuarios();
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