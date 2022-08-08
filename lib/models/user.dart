import 'package:cloud_firestore/cloud_firestore.dart';

class Usuarios {
  
  String? id;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  bool admin = false;

  Usuarios({this.id, this.name, this.email, this.password, this.confirmPassword});

  // Buscando dados do usuário no Firebase de Map para objeto
  Usuarios.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document['name'] as String;
    email = document['email'] as String;
  }



  // instanciando o Firestore
  FirebaseFirestore db = FirebaseFirestore.instance;
  // Buscando o usuário no Firebase
  CollectionReference get firestoreRef => db.collection('users/$id');

  // Buscar produtos salvos no carrinho
  CollectionReference get cartReference => db.collection('users/$id/cart'); 

  // Salvando dados no Firebase Firestore
  Future<void> saveData() async {

    await firestoreRef.doc(id).set(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
    };
  }

}