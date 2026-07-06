import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/screens/menus/menu_configuracoes.dart';
import 'package:appcompanion/screens/usuario/lista_usuarios.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:appcompanion/widgets/base/appbar.dart';
import 'package:appcompanion/widgets/botoes/menu_buttons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.title});

  final String? title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = getIt<IAuthService>();

  bool carregando = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titulo: "Home",
        actions: [
        ],
      ),
      body: 
      Container(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
        child:  
          Align(
            alignment: Alignment.topCenter,
            child: 
              FractionallySizedBox(
                widthFactor: 0.85,
                child: Wrap(  // equivalente ao flexbox
                  spacing: 16, // espaço entre itens
                  runSpacing: 16, 
                  alignment: WrapAlignment.spaceAround,// espaço entrelinhas
                  children: [
                    MenuButton(icon: Icons.gamepad, title: "Dead by Daylight", onTap: () => _configuracoes()), 
                    MenuButton(icon: Icons.catching_pokemon, title: "Pokémon Champions", onTap: () => _configuracoes()), 
                    MenuButton(icon: Icons.settings, title: "Configurações", onTap: () => _configuracoes()), 
                  ],
                ),
              )
            )
        )
      );
  }

  void _configuracoes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConfigMenu(),
      ),
    );
  }
}