import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/models/products.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/usermanager.dart';

class CartManager extends ChangeNotifier{
  List<CartProduct> items = [];

  Usuarios? user;

  num productsPrice = 0.0;

  void updateUser(UserManager userManager){

    user = userManager.usuarioAtual;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }

  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user!.cartReference.get();

    items = cartSnap.docs.map(
      (d) => CartProduct.fromDocument(d)..addListener(_onItemUpdate)
    ).toList();
  }

  // Adicionando os produtos no carrinho / Firestore
  void addToCart(Product product){
    
    // e = empilhavel
    // p = produto
    // Empilhando itens iguais
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      //e.quantity = e.quantity!+1;
      e.increment();
    } catch (e) {
      // Adicionando produtos ao carrinho
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdate);
      items.add(cartProduct);
      user!.cartReference.add(cartProduct.toCartItemMap())
        .then((doc) => cartProduct.id = doc.id);
      _onItemUpdate();
    }

  }

  // Removendo item do carrinho
  void removeFromCart(CartProduct cartProduct){
    items.removeWhere((p) => p.id == cartProduct.id);
    // Removendo do FireStore
    user!.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdate); // removendo o listener
    notifyListeners();
  }

  // Obtendo atualizações de itens
  void _onItemUpdate(){
    productsPrice = 0.0;

    // For iterando sobre os itens e quando
    // o item for retirado para a iteração
    for (int i = 0; i<items.length;i++) {
      final cartProduct = items[i];

      if (cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
        i--;
        continue;
      }

      // Somando os preços no carrinho
      productsPrice += cartProduct.totalPrice;

      // Atualizando o carrinho
      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }

  // Atualizando o item do carrinho no Firestore
  void _updateCartProduct(CartProduct cartProduct){
    if (cartProduct.id != null){
      user!.cartReference.doc(cartProduct.id)
      .update(cartProduct.toCartItemMap());
    }
    
  }

  // Validar se o carrinho é valido ou não
  bool get isCartValid{
    for (final cartProduct in items){
      if(!cartProduct.hasStock) return false;
    }
    return true;
  }

}