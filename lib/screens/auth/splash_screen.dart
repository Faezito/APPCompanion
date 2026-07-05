import 'package:appcompanion/screens/auth/login_screen.dart';
import 'package:appcompanion/screens/usuario/lista_usuarios.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final isLogged = await AuthService.isLoggedIn();

    if (!mounted) return;

    if (isLogged) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ListaUsuariosScreen())
        );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}