import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/helper/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';

class UserManager extends ChangeNotifier {

  // Verificar se o usuário já esta logado
  UserManager(){
    _loadCurrenteUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
    
  Usuarios? usuarioAtual;

  // animação de loading
  bool _loading = false;
  bool get loading => _loading;
  // animação de loading
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool get isLoggedIn => usuarioAtual != null;



  // Capturar os dados do cadastro do usuario
  Future <void> signUp({Usuarios? user, Function? onFail, Function? onSuccess}) async {
    loading = true;

    try{
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: user!.email!, 
        password: user.password!,
      );

      
      //usuarioAtual = result.user!;
      // Recuperando o id do usuário no Firestore
      user.id = result.user!.uid;
      usuarioAtual = user; // Recebendo o usuário cadastrado e logando
      await user.saveData();
      
      onSuccess!();

      
    }on FirebaseAuthException catch(e){
      onFail!(getErrorString(e.code));
    }
    loading = false;
  }


  void signOut(){
    auth.signOut();
    usuarioAtual = null;
    notifyListeners();
  }

    
  // Verificar se o usuário já esta logado
  Future <void> _loadCurrenteUser({dynamic firebaseUser}) async {

    final User? currentUser = firebaseUser ?? await auth.currentUser;
        
    if (currentUser != null){

      final DocumentSnapshot docUser = await db.collection('users')
          .doc(currentUser.uid).get();  
      usuarioAtual = Usuarios.fromDocument(docUser);

      final docAdmin = await db.collection('admins').doc(usuarioAtual!.id).get();
      if (docAdmin.exists){
        usuarioAtual!.admin = true;
      } 


      print(usuarioAtual!.admin);


      notifyListeners();
    }
  }

  // Verificando se é admin ou usuario
  bool get adminEnabled => usuarioAtual != null && usuarioAtual!.admin;

  // Logar usuário
  Future<void> signIn({required Usuarios user, Function? onFail, Function? onSuccess}) async {
    loading =true;

    try{
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email!, 
        password: user.password!,
      );

      
      await _loadCurrenteUser(firebaseUser: result.user);
      
      onSuccess!();
      debugPrint(result.user!.uid);
      debugPrint(result.user!.email);
      debugPrint(usuarioAtual?.name);
    } on FirebaseAuthException catch(e){
      onFail!(getErrorString(e.code));
      
    }
    
    loading = false;
  }

}