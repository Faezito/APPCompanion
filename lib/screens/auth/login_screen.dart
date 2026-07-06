import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/models/requests/login.dart';
import 'package:appcompanion/screens/usuario/cadastro_screen.dart';
import 'package:appcompanion/screens/usuario/lista_usuarios.dart';
import 'package:appcompanion/services/acesso_service.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:appcompanion/widgets/snackbar/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final IAcessoService _acessoService = getIt<IAcessoService>();

  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  final storage = FlutterSecureStorage();

  bool carregando = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: SizedBox(
          width: 320,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Game Companion",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 1, 38, 86),
                    fontSize: 24.0
                    ),
                  strutStyle: const StrutStyle(
                    height: 5.0
                  ),
                ),
                TextFormField(
                  controller: _loginController,
                  decoration: const InputDecoration(labelText: "E-mail ou usuário"),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail ou usuário';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _senhaController,
                  decoration: const InputDecoration(labelText: "Senha"),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(16.0),
                  child: Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 25.0,
                    children: [
                      ElevatedButton(
                        onPressed: carregando ? null : _login,
                        child: carregando ? const CircularProgressIndicator() : const Text("Entrar"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CadastroScreen(),
                            ),
                          );
                        },
                        child: const Text("Cadastrar"),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                      onPressed: () {
                      },
                  child: const Text("Recuperar Senha"),
                ),
              ],
            ),
          )
        )
      )
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()){
      return;
    }

    setState(() {
      carregando = true;
      });

    try {
        final acesso = await _acessoService.login(LoginRequest(login: _loginController.text, senha: _senhaController.text));
        AuthService.salvarSessao(
            token: acesso.token, 
            expiration: acesso.expiration ?? DateTime.now().add(Duration(hours: 3)),
            perfil: acesso.usuario!.perfil
          );
        SnackbarService.snackSucesso("Logado com sucesso! Bem-vindo de volta ${acesso.usuario?.nomeCompleto}");

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ListaUsuariosScreen(),
          ),
        );
      }
      catch(ex){
        SnackbarService.snackErro(ex.toString().replaceFirst("Exception: ", ""));
      }
      finally{
        if(mounted){
          setState(() {
            carregando = false;
          });
        }
      }
    }

}