import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/models/requests/usuario_att_request.dart';
import 'package:appcompanion/models/responses/usuario_response.dart';
import 'package:appcompanion/services/auth_service.dart';
import 'package:appcompanion/services/usuario_service.dart';
import 'package:appcompanion/widgets/base/appbar.dart';
import 'package:appcompanion/widgets/dropdowns/perfil_dropdown.dart';
import 'package:appcompanion/widgets/snackbar/snackbar_service.dart';
import 'package:flutter/material.dart';

class EditarUsuarioScreen extends StatefulWidget {
   final int usuarioId;

   const EditarUsuarioScreen({super.key, required this.usuarioId});

   @override
   State<EditarUsuarioScreen> createState() => _EditarUsuarioScreenState();
 }

 class _EditarUsuarioScreenState extends State<EditarUsuarioScreen> {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    int? _perfilSelecionado = 5;

    final usuarioService = getIt<IUsuarioService>();
    final _auth = getIt<IAuthService>();

    bool carregando = true;

    late UsuarioResponse usuario;

    @override
    void initState() {
      super.initState();
      _carregarUsuario();
    }

    Future<void> _carregarUsuario() async {
      usuario = await usuarioService.obterPorId(widget.usuarioId);
      _emailController.text = usuario.email;
      _perfilSelecionado = usuario.perfil;

      setState(() {
        carregando = false;
      });
    }
        
  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: BaseAppBar(titulo: "Editar Usuário", actions: [],),
      body: 
      Center(
        child: FractionallySizedBox(
          widthFactor: 0.75,

          child: Form(
            key: _formKey,
            child:  LayoutBuilder(
              
              builder: (context, constraints) {
                if(constraints.maxWidth < 600){
                  return Column(children: [
                      Text(usuario.nomeCompleto, style: TextStyle(fontSize: 24)),

                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: "Email"),
                        ),

                    const SizedBox(height: 15),

                    if(_auth.isAdmin)
                          PerfilDropdown(
                            value: _perfilSelecionado, 
                              onChanged: (value) {
                                      setState(() {
                                        _perfilSelecionado = value;
                                      });
                                }
                            ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: salvar,
                      child: const Text("Salvar"),
                        ),
                      ],
                    );
                  }
              else{
                return Row(
                  children: [
                    Expanded(
                    child:   
                    Text("Usuário: ${usuario.nomeUsuario} - ${_auth.isAdmin ? "1" : "2"}"),
                  ),

                    const SizedBox(width: 20,),

                    Expanded(
                      child: 
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: "Email"),
                        ),
                    ),

                    const SizedBox(width: 20),

                    if(_auth.isAdmin)
                    Expanded(
                        child: 
                          PerfilDropdown(
                            label: "Perfil",
                            value: _perfilSelecionado, 
                              onChanged: (value) {
                                      setState(() {
                                        _perfilSelecionado = value;
                                      });
                                }
                            ),
                        ),

                    ElevatedButton(
                      onPressed: salvar,
                      child: const Text("Salvar"),
                    ),
                  ],
                );
              }
            }
          ),
         ),
        ),
      ),
    );
  }

  Future<void> salvar() async {
    if (_formKey.currentState!.validate()) {
      try {
        await usuarioService.atualizarUsuario(
          usuarioEdicaoRequest: UsuarioAtualizacaoRequest(
            id: usuario.id,
            email: _emailController.text
          )
        );

        SnackbarService.snackSucesso('Usuário atualizado com sucesso!');
      } catch (e) {
        SnackbarService.snackErro('Erro ao atualizar usuário: $e');
      }
    }
  }
}