import 'package:flutter/material.dart';
import 'package:loja_virtual/models/pagemanager.dart';
import 'package:loja_virtual/models/usermanager.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserManager>(
        builder: (_, userManager,__){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
        
            const Text(
              'Loja do\n Felipe',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            

              Text(
                'Olá, ${userManager.usuarioAtual?.name  ?? 'Bem-vindo(a)'}',  
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor
                ),
              ),
              
              GestureDetector(
                onTap: (){
                  if( userManager.isLoggedIn ){
                    context.read<PageManeger>().setPage(0);
                    userManager.signOut();
                  }else{
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(

                  userManager.isLoggedIn
                    ? 'Sair'
                    : 'Entre ou cadastre-se',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )

            ],
          );
        },
      )
    );
  }
}