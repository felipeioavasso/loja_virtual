import 'package:flutter/material.dart';
import 'package:loja_virtual/commom/priceCard.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:provider/provider.dart';

import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),

      body: Consumer<CartManager>(
        builder: (_, cartManager, __){
          return ListView(
            children: <Widget>[

              Column(
                children: cartManager.items.map(
                  (cartProduct) => CartTile(cartProduct)
                ).toList(),
              ),

              PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid ? (){

                } : null,
              ),

            ],
          );
        },
      ),
    );
  }
}