import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({Key? key, this.buttonText, this.onPressed}) : super(key: key);

  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            const Text(
              'Resumo do pedido',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'SubTotal',
                ),
                Text('R\$ ${productsPrice.toStringAsFixed(2)}')
              ],
            ),

            const Divider(),

            const SizedBox(height: 12),

            // Entrega

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Total',
                  style: TextStyle(
                   fontWeight: FontWeight.w500,
                 ),
                ),
                Text(
                  'R\$ ${productsPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16
                  ),
                )
              ],
            ),

            const SizedBox(height: 8,),

            ElevatedButton(
              onPressed: onPressed, 
              child: Text(buttonText!),
              
            ),

          ],
        ), 
      ),
    );
  }
}