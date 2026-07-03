import 'package:appcompanion/models/responses/usuario_response.dart';
import 'package:appcompanion/screens/usuario/alterar_senha_screen.dart';
import 'package:appcompanion/screens/usuario/editar_screen.dart';
import 'package:appcompanion/services/usuario_service.dart';
import 'package:flutter/material.dart';

class ListaUsuariosScreen extends StatefulWidget {
  const ListaUsuariosScreen({super.key});

  @override
  State<ListaUsuariosScreen> createState() => _ListaUsuariosScreenState();
}

class _ListaUsuariosScreenState extends State<ListaUsuariosScreen> {
  late Future<List<UsuarioResponse>> usuariosFuture;

  @override
  void initState() {
    super.initState();
    usuariosFuture = UsuarioService().listarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Usuários")),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AlterarSenhaScreen(usuarioId: usuario.id),
                            ),
                          );
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