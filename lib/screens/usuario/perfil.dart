import 'package:appcompanion/core/convert/datetime_ext.dart';
import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:appcompanion/widgets/base/appbar.dart';
import 'package:flutter/material.dart';

class PerfilUsuarioScreen extends StatefulWidget {

  const PerfilUsuarioScreen ({ super.key });
  
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
    

    return Scaffold(
      appBar: BaseAppBar(titulo: "Perfil de ${_auth.usuario?.nomeCompleto}", actions: [],),
      body: 
      LayoutBuilder(builder: ((context, constraints) {
      double wdfator = constraints.maxWidth < 600 ? 0.9 : 0.6;
      return
      FractionallySizedBox(
        widthFactor: wdfator,

        child: ListView(
          children:
            <Widget>[
              ListTile(title: Text("Nome: ${_auth.usuario?.nomeCompleto}"), trailing: Icon(Icons.edit),),
              ListTile(title: Text("Usuário: ${_auth.usuario?.nomeUsuario}"), trailing: Icon(Icons.edit),),
              ListTile(title: Text("E-mail: ${_auth.usuario?.email}"), trailing: Icon(Icons.edit),),
              ListTile(title: Text("Gênero: ${_auth.usuario?.genero}"), trailing: Icon(Icons.edit),),
              ListTile(title: Text("Data de Nascimento: ${_auth.usuario?.nascimento}"), trailing: Icon(Icons.edit),),
              ListTile(title: Text("Perfil: ${_auth.usuario?.perfilTxt}"), trailing: Icon(Icons.edit),),
          ],
        ),
      );
  }
  )
  )
  );
  }

}