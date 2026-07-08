import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/screens/auth/login_screen.dart';
import 'package:appcompanion/screens/menus/menu_configuracoes.dart';
import 'package:appcompanion/screens/usuario/perfil.dart';
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
      backgroundColor: const Color.fromARGB(130, 129, 168, 235),
      title: Text(titulo),
      actions: [
            ...?actions,
             PopupMenuButton<String>(
                icon: const Icon(Icons.account_circle),
                onSelected: (value) async {
                  switch (value) {
                    case "perfil":
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PerfilUsuarioScreen()));
                      break;

                    case "config":
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ConfigMenu()));
                      break;

                    case "logout":
                      await auth.logout();
                      if(!context.mounted) return;

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false
                      );                      
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "perfil",
                    child: Text("Meu Perfil"),
                  ),
                  if(auth.isAdmin)
                  const PopupMenuItem(
                    value: "config",
                    child: Text("Configurações"),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: "logout",
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8),
                        Text("Sair"),
                      ],
                    ),
                  ),
                ],
              ),

      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}