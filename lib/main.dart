import 'package:appcompanion/models/responses/usuario_response.dart';
import 'package:appcompanion/screens/home.dart';
import 'package:appcompanion/screens/usuario/alterar_senha_screen.dart';
import 'package:appcompanion/screens/usuario/cadastro_screen.dart';
import 'package:appcompanion/screens/usuario/editar_screen.dart';
import 'package:appcompanion/services/usuario_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const AlterarSenhaScreen(usuarioId: 1),
      // home: const EditarUsuarioScreen(usuarioId: 1),
      // home: const CadastroScreen(),
      home: HomePage(title: 'Pagina Inicial'),
    );
  }
}
