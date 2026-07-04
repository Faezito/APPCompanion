import 'package:appcompanion/screens/auth/login_screen.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthGuard {
  static Future<void> validate(BuildContext context) async {
    final isLogged = await AuthService.isLoggedIn();

    if (!isLogged && context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }
}