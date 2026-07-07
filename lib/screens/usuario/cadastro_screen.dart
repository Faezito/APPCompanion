import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/models/requests/usuario_cadastro.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:appcompanion/services/usuario_service.dart';
import 'package:appcompanion/widgets/base/appbar.dart';
import 'package:appcompanion/widgets/dropdowns/perfil_dropdown.dart';
import 'package:appcompanion/widgets/snackbar/snackbar_service.dart';
import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

   @override
   State<CadastroScreen> createState() => _CadastroScreenState();
 }
 
 class _CadastroScreenState extends State<CadastroScreen> {
   final _formKey = GlobalKey<FormState>();
   int? _perfilSelecionado = 5;

   @override
   void initState(){
    super.initState();
   }

   final _nomeCompletoController = TextEditingController();
   final _nomeUsuarioController = TextEditingController();
   final _emailController = TextEditingController();
   final _senhaController = TextEditingController();
   String? _generoSelecionado;
   DateTime? _dataNascimento;

   final _usuarioService = getIt<IUsuarioService>();
   final _auth = getIt<IAuthService>();

   bool carregando = false;

   Future<void> _cadastrarUsuario() async {
     if (_formKey.currentState!.validate()) {
       setState(() {
         carregando = true;
       });

       try {
          await _usuarioService.cadastrarUsuario(usuarioCadastro: UsuarioCadastro(
            nomeCompleto: _nomeCompletoController.text,
            nomeUsuario: _nomeUsuarioController.text,
            email: _emailController.text,
            senha: _senhaController.text,
            genero: _generoSelecionado!,
            dataNascimento: _dataNascimento ?? DateTime.now(),
          ));

         SnackbarService.snackSucesso('Usuário cadastrado com sucesso!');

          _nomeCompletoController.clear();
          _nomeUsuarioController.clear();
          _emailController.clear();
          _senhaController.clear();
          setState(() => _generoSelecionado = null);
         _dataNascimento = null;

         Navigator.pop(context, true); // Retorna true para indicar que o usuário foi cadastrado com sucesso
       } catch (e) {
         SnackbarService.snackErro('Erro ao cadastrar usuário: $e');
       } finally {
         setState(() {
           carregando = false;
         });
       }
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titulo: 'Cadastro de Usuário',
        actions: [],
      ),
      body: 
      Center(
        child: FractionallySizedBox(
        widthFactor: 0.75,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: _nomeCompletoController,
                decoration: const InputDecoration(labelText: 'Nome Completo'),
                validator: (value)  =>
                value!.isEmpty ? "Informe o nome completo" : null,
              ),
              const SizedBox(height: 16,),
              Row(
              children: [
                Expanded(
                  child:
                    TextFormField(
                      controller: _nomeUsuarioController,
                      decoration: const InputDecoration(labelText: 'Nome de Usuário'),
                      validator: (value)  =>
                      value!.isEmpty ? "Informe o nome completo" : null,
                    )),

                const SizedBox(width: 16,),

                Expanded(
                  child: 
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value)  =>
                      value!.isEmpty ? "Informe o email" : null,
                    ),              
                )
                ]
              ),

              const SizedBox(height: 16,),

              Row(
                children: [
                  Expanded(
                    child:
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                  hintText: _dataNascimento != null
                      ? '${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}'
                      : 'Selecione a data de nascimento',
                ),
                onTap: () async {
                  DateTime? dataSelecionada = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    initialEntryMode: DatePickerEntryMode.input,
                  );
                  if (dataSelecionada != null) {
                    setState(() {
                      _dataNascimento = dataSelecionada;
                    });
                  }
                },
              ),
                  ),
                  SizedBox(width: 16,),
                  
                  Expanded(
                    child:
                      DropdownButtonFormField<String>(
                        initialValue: _generoSelecionado,
                        decoration: const InputDecoration(labelText: 'Gênero'),
                        items: const [
                          DropdownMenuItem(value: 'M', child: Text('Masculino')),
                          DropdownMenuItem(value: 'F', child: Text('Feminino')),
                          DropdownMenuItem(value: 'O', child: Text('Outro')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _generoSelecionado = value;
                          });
                        },
                        validator: (value)  =>
                        value == null ? "Informe o gênero" : null,
                      ),
                  )
            ]),

              const SizedBox(height: 16,),

              Row(
                children: [
                  Expanded(
                    child:
                      TextFormField(
                        controller: _senhaController,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        validator: (value)  =>
                        value!.isEmpty ? "Informe a senha" : null,
                        obscureText: true,
                      ),
                    ),

                  const SizedBox(width: 16.0),

                  if(_auth.isAdmin)
                    Expanded(
                      child:
                        PerfilDropdown(
                    value: _perfilSelecionado, 
                      onChanged: (value) {
                              setState(() {
                                _perfilSelecionado = value;
                              });
                        }
                    ),
                  ),
                ]),


                const SizedBox(height: 48.0),
                ElevatedButton(
                  onPressed: carregando ? null : _cadastrarUsuario,
                  child: carregando
                      ? const CircularProgressIndicator()
                      : const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}