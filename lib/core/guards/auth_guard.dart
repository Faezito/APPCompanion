import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/screens/auth/login_screen.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthGuard {
  final _auth = getIt<IAuthService>();

  Future<void> validate(BuildContext context) async {
    final isLogged = await _auth.isLoggedIn();

    if (!isLogged && context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }
}