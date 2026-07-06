import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/screens/auth/login_screen.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final List<Widget>? actions;


  const BaseAppBar ({
    super.key, 
    required this.titulo,
    this.actions,
  });

  @override
  Widget build(BuildContext context){
    final auth = getIt<IAuthService>();
    return AppBar(
      title: Text(titulo),
      actions: [
            ...?actions,
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: "Sair",
              onPressed: () async {
               await auth.logout();
               if(!context.mounted) return;

               Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false
               );
              }
            )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}