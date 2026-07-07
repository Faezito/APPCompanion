import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/screens/auth/login_screen.dart';
import 'package:appcompanion/screens/home.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = getIt<IAuthService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLogin();
    });
  }

  Future<void> _checkLogin() async {
    final isLogged = _auth.isLoggedIn();

    if (!mounted) return;

    if (isLogged) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(title: "Tela inicial"))
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