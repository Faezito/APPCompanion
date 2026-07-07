import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/screens/usuario/lista_usuarios.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:appcompanion/widgets/base/appbar.dart';
import 'package:appcompanion/widgets/botoes/menu_buttons.dart';
import 'package:flutter/material.dart';

class ConfigMenu extends StatefulWidget {
  const ConfigMenu ({super.key});

  @override
  State<ConfigMenu> createState() => _ConfigMenuState();
}

class _ConfigMenuState extends State<ConfigMenu> {
  final _auth = getIt<IAuthService>();
  bool carregando = false;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!_auth.isAdmin){
      throw Exception("Acesso negado.");
    }
    
    return Scaffold(
      appBar: BaseAppBar(titulo: "Configurações"),
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: Align(alignment: Alignment.topCenter,
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.spaceAround,
              children: [
                MenuButton(icon: Icons.people, title: "Usuários", onTap: () => _listaUsuarios())
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listaUsuarios(){
    Navigator.push(context, 
    MaterialPageRoute(builder: (_) => ListaUsuariosScreen()));
  }
}