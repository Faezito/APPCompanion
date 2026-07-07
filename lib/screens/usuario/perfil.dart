import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:appcompanion/widgets/base/appbar.dart';
import 'package:flutter/material.dart';

class PerfilUsuarioScreen extends StatefulWidget {

  PerfilUsuarioScreen ({ super.key });
  
  @override
  State<StatefulWidget> createState() => _PerfilUsuarioScreen();
}

class _PerfilUsuarioScreen extends State<PerfilUsuarioScreen> {
  final _auth = getIt<IAuthService>();

  bool carregando = true;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    if(carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: BaseAppBar(titulo: "Perfil de ${_auth.usuario?.nomeCompleto}", actions: [],),
      body: FractionallySizedBox(
        widthFactor: 0.75,

        child: ,
      ),
    );
  }
}