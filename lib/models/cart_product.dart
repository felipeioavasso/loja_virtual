import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/models/products.dart';

class CartProduct extends ChangeNotifier{

  CartProduct.fromProduct(this.product){
    productId = product!.id;
    quantity = 1;
    size = product!.selectedSize!.name;
  }

  // Buscando no Firestore o produto para adicionar no carrinho
  CartProduct.fromDocument(DocumentSnapshot document){
    id = document.id;
    productId = document['pid'] as String;
    quantity = document['quantity'] as int;
    size = document['size'] as String;
  
    firestore.doc('products/$productId').get().then(
      (doc) {
        product = Product.fromDocument(doc);
        notifyListeners();
      }
    );
  }
  // Fim

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Product? product;
  String? id;
  String? productId;
  int? quantity;
  String? size;

  ItemSize? get itemSize {
    if (product == null) return null;
    return product!.findSize(size!);
  }


  // Preço unitário
  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }

  // Preço total
  num get totalPrice => unitPrice * quantity!;

  // Mapa para converter o objeto em Map para salvar no Firestore
  Map<String, dynamic> toCartItemMap(){
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }
  
  // Empilhando items iguais no carrinho
  bool stackable(Product product){
    return product.id == productId && product.selectedSize!.name == size;
  }

  void increment(){
    quantity = quantity! + 1;
    notifyListeners();
  }

  void decrement(){
    quantity = quantity! - 1;
    notifyListeners();
  }

  bool get hasStock {
    final size = itemSize;
    if ( size == null ) return false;
    return size.stock! > quantity!;
  }

}