
import 'package:appcompanion/models/responses/usuario_response.dart';
import 'package:appcompanion/screens/usuario/cadastro_screen.dart';
import 'package:appcompanion/screens/usuario/lista_usuarios.dart';
import 'package:appcompanion/services/usuario_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final UsuarioService usuarioService = UsuarioService();

  late Future<List<UsuarioResponse>> usuarioFuture;

  @override
  void initState() {
    super.initState();
    usuarioFuture = usuarioService.listarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Game Companion',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CadastroScreen(),
                    ),
                  );
                },
                child: const Text("Cadastrar usuário"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ListaUsuariosScreen(),
                    ),
                  );
                },
                child: const Text("Listar usuários"),
              ),
              const SizedBox(height: 20),
            ]
          )
        )
      )
    );
  }
}
