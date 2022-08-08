import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loja_virtual/models/admin_users_manager.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/products.dart';
import 'package:loja_virtual/models/usermanager.dart';
import 'package:loja_virtual/screens/base/basescreen.dart';
import 'package:loja_virtual/screens/cart/cart_screen.dart';
import 'package:loja_virtual/screens/edit_product/edit_product_screen.dart';
import 'package:loja_virtual/screens/login/loginscreen.dart';
import 'package:loja_virtual/screens/product/product_screen.dart';
import 'package:loja_virtual/screens/signup/signup.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';


void main() async {

  //------------- FIREBASE - INICIO
  // Inicializando os serviços do Firebase

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  
  //------------- TEMAS - FIM


  runApp(MultiProvider(
    providers: [

      ChangeNotifierProvider(
        create: (_) => UserManager(),
        lazy: false, 
      ),

      ChangeNotifierProvider(
        create: (_) => ProductManager(),
        lazy: false,
      ),

      ChangeNotifierProvider(
        create: (_) => HomeManager(),
        lazy: false,
      ),

      ChangeNotifierProxyProvider<UserManager, CartManager>(
        create: (_) => CartManager(),
        lazy: false,
        update: (_, userManager, cartManager) => 
          cartManager!..updateUser(userManager),
      ),

      ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
        create: (_) => AdminUsersManager(),
        lazy: false,
        update: (_, userManager, adminUsersManager) =>
          adminUsersManager!..updateUser(userManager),
      ),

    ],
    child: MaterialApp(
      title: 'Loja',
      debugShowCheckedModeBanner: false,
      //home: const BaseScreen(),
    
      //------------- TEMAS - INICIO
      theme: ThemeData(
    
        visualDensity: VisualDensity.adaptivePlatformDensity,
    
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 4, 125, 141),
          primary: const Color.fromARGB(255, 4, 125, 141),
        ),
    
        scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
        
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Color.fromARGB(255, 4, 125, 141),
        ),
    
      ),
      //------------- TEMAS - FIM
    
      //------------- ROTAS - INICIO
      initialRoute: '/base',
      onGenerateRoute: (settings){
        switch(settings.name){
          case '/base':
            return MaterialPageRoute(
              builder: (_) => const BaseScreen(),
            );
          case '/signup':
            return MaterialPageRoute(
              builder: (_) => SignUpScreen(),
            );
          case '/login':
            return MaterialPageRoute(
              builder: (_) => LoginScreen(),
            );
          case '/producScreen':
            return MaterialPageRoute(
              builder: (_) => ProducScreen(settings.arguments as Product),
            );
          case '/cart':
            return MaterialPageRoute(
              builder: (_) => const CartScreen(),
            );
          case '/edit_product':
            return MaterialPageRoute(
              builder: (_) => EditProductScreen(settings.arguments as Product),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => const BaseScreen(),
            );
        }
      },
      //------------- ROTAS - FIM
      
    ),
  ));
}


