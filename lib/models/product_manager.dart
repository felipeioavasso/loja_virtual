import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/products.dart';

class ProductManager extends ChangeNotifier{

  //------------ Carregar Produtos - Inicio
  ProductManager(){
    _loadAllProducts();
  }
  //------------ Carregar Produtos - Fim

  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<Product> allProducts = [];

  //------------ Variável de busca - Inicio
  String? _search = '';
  String get search => _search!;

  set search(String value){
    _search = value;
    notifyListeners();
  }
  //------------ Variável de busca - Fim
  //------------ Sistema de busca - Inicio
  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (search.isEmpty){
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(
        allProducts.where((produto) => produto.name!.toLowerCase().contains(search)));
    }

    return filteredProducts;
  }
  //------------ Sistema de busca - Fim
  //------------ Carregar produtos do Firebase Firestore
  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts = 
      await db.collection('products').get();

     allProducts = snapProducts.docs.map(
      (d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }

  Product? findProductByID(String id){
    
    try {
      return allProducts.firstWhere((p) => p.id == id);
    }catch (e) {
      return null;
    }
    
  }

}

