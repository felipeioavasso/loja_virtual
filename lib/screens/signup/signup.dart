import 'package:flutter/material.dart';
import 'package:loja_virtual/helper/validator.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/usermanager.dart';
import 'package:provider/provider.dart';
import '../../models/snackbar_manager/snackbar_manager.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final Usuarios usuario = Usuarios();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: AppBar(
        title: const Text('Criar conta'),
        centerTitle: true,
      ),

      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, UserManager, __){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
              
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Nome completo'),
                      enabled: !UserManager.loading,
                      validator: (name){
                        if(name!.isEmpty){
                          return 'Campo Obrigatório';
                        }else if (name.trim().split(' ').length <= 1){
                          return 'Preencha seu nome completo';
                        }else {
                          return null;
                        }
                      },
                      onSaved: (name) => usuario.name = name!,
                    ),
              
                    const SizedBox(height: 16),
              
              
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !UserManager.loading,
                      validator: (email){
                        if(email!.isEmpty){
                          return 'Campo obrigatório';
                        }else if (!emailValid(email)){
                          return 'E-mail inválido';
                        }else {
                          return null;
                        }
                      },
                      onSaved: (email) => usuario.email = email!,
                    ),
              
                    const SizedBox(height: 16),
              
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      enabled: !UserManager.loading,
                      validator: (pass){
                        if (pass!.isEmpty){
                          return 'Campo Obrigatório';
                        }else if (pass.length <= 6){
                          return 'Senha muito curta';
                        }else {
                          return null;
                        }
                      },
                      onSaved: (pass) => usuario.password = pass!,
                    ),
              
                    const SizedBox(height: 16),
              
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Repita a senha'),
                      obscureText: true,
                      enabled: !UserManager.loading,
                      validator: (pass){
                        if (pass!.isEmpty){
                          return 'Campo Obrigatório';
                        }else if (pass.length <= 6){
                          return 'Senha muito curta';
                        }else {
                          return null;
                        }
                      },
                      onSaved: (pass) => usuario.confirmPassword = pass!,
                    ),
              
                    const SizedBox(height: 16),
              
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: UserManager.loading ? null : (){

                          if (formKey.currentState!.validate()){
                            formKey.currentState!.save();

                            if (usuario.password != usuario.confirmPassword){
                              SnackbarManager().showErro(context, 'Senhas não coincidem');
                              return;
                            }

                            UserManager.signUp(
                              user: usuario,
                              onSuccess: (){
                                debugPrint('Cadastro realizado com sucesso!');
                                Navigator.of(context).pop();
                              },
                              onFail: (e){
                                SnackbarManager().showErro(context, 'Falha ao cadastrar: $e');
                              }
                            );
                          }

                          debugPrint('Conta criada com sucesso');
                        },
                        child: UserManager.loading ?
                          const CircularProgressIndicator()
                          : const Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 18),
                        ),
                    
                      ),
                    ),
              
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}