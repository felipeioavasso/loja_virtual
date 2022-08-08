import 'package:flutter/material.dart';
import 'package:loja_virtual/models/snackbar_manager/snackbar_manager.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/usermanager.dart';
import 'package:provider/provider.dart';
import '../../helper/validator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  late final String pass;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>(); 

  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    final Color primaryColor = Theme.of(context).primaryColor;    

    return Scaffold(
      key: scaffoldMessengerKey,

      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 4, 125, 141),
              elevation: 0
            ),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/signup');
            }, 
            child: const Text(
              'Criar conta',
            ),
          ),
        ],
      ),

      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, UserManager, __){
                return ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
            
                children: <Widget>[
            
                  TextFormField(
                    controller: emailController,
                    enabled: !UserManager.loading,
                    decoration: const InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autofocus: true,
                    validator: (email){
                      if (!emailValid(email!)){
                        return 'E-mail inválido';
                      }else{
                        return null;
                      }
                        
                    },
                  ),
            
                  const SizedBox(height: 16),
            
                  TextFormField(
                    controller: passController,
                    enabled: !UserManager.loading,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    autocorrect: false,
                    validator: (pass){
                      if(pass!.isEmpty || pass.length < 6) {
                        return 'Senha inválida';
                      }else {
                        return null;
                      }
                      
                    },
                  ),
            
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: (){}, 
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        primary: Colors.white,
                        elevation: 0,
                      ),
                      child: Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 16),
            
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: UserManager.loading ? null : (){
                        if(formKey.currentState!.validate()){
                          UserManager.signIn(

                            user: Usuarios(
                              id: '',
                              name: '',
                              email: emailController.text,
                              password: passController.text,
                              confirmPassword: ''
                            ),

                            onFail: (e){
                              debugPrint(e);
                              SnackbarManager().showErro(context, 'Falha no login: $e');
                            },

                            onSuccess: (){
                              debugPrint('Login feito com sucesso');
                              Navigator.of(context).pop();
                            }

                          );
                        }
                      },
                      child: UserManager.loading ?
                        const CircularProgressIndicator(
                          //valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ) :
                        const Text('Entrar', style: TextStyle(fontSize: 18),),
                    ),
                  ),
            
                ],
            
              );
              } 
            ),
          ),

        ),
      ),
    );
  }
}