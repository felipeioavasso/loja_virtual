import 'package:flutter/material.dart';

import 'package:loja_virtual/commom/customdrawer/customdrawer.dart';

import '../../models/usermanager.dart';
import 'package:loja_virtual/models/pagemanager.dart';

import 'package:loja_virtual/screens/admin_users/admin_users_screen.dart';
import 'package:loja_virtual/screens/home/home_screen.dart';
import 'package:loja_virtual/screens/products/products_screen.dart';

import 'package:provider/provider.dart';



class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  final PageController pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManeger(pageController),
        child: Consumer<UserManager>(
          builder: (_, userManager, __){
            return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
        
              const HomeScreen(),
        
              const ProductsScreen(),
        
              Scaffold(
                drawer: const CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Meus pedidos '),
                ),
              ),
        
              Scaffold(
                drawer: const CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Lojas'),
                ),
              ),

              if (userManager.adminEnabled)
                ...[// Adicionando novos itens à lista
                  const AdminUsersScreen(),
            
                  Scaffold(
                    drawer: const CustomDrawer(),
                    appBar: AppBar(
                      title: const Text('pedidos'),
                    ),
                  ),
                ]
        
            ],
          );
        },
      ),
    );
  }
}