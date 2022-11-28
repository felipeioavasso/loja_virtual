import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/products.dart';
import 'package:loja_virtual/models/usermanager.dart';
import 'package:provider/provider.dart';

import '../products/components/size_widget.dart';

class ProducScreen extends StatelessWidget {
  //const ProducScreen({Key? key}) : super(key: key);

  const ProducScreen(this.product, {Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
    
        appBar: AppBar(
          title: Text(product.name!),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __){
                if (userManager.adminEnabled){
                  return IconButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed(
                        '/edit_product',
                        arguments: product,
                      );
                    }, 
                    icon: const Icon(Icons.edit),
                  );
                } else {
                  return Container();
                }
              }
            ),
          ],
        ),
    
        body: ListView(
          children: <Widget>[
    
            AspectRatio(
              aspectRatio: 1,
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.0,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                ),
                items: product.images?.map((url) => 
                  Center(
                    child: Image.network(url),
                  ),
                ).toList(),
              ),
            ),
    
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.name!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
    
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ), 
                  ),
                  
                  Text(
                    'R\$ ${product.basePrice!.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                    ),
                  ),
    
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ), 
                  ),
    
                  Text(
                    product.description!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
    
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ), 
                  ),
    
                  // Tamanho das peças
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.sizes!.map((s){
                      return SizeWidget(size: s);
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __){
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: product.selectedSize != null ? (){
                              if ( userManager.isLoggedIn ){
                                //enviando o produto para o carrinho
                                context.read<CartManager>().addToCart(product);
                                Navigator.of(context).pushNamed('/cart');
                              } else {
                                Navigator.of(context).pushNamed('/login');
                              }
                            } : null,
                            child: Text(
                              userManager.isLoggedIn
                                ? 'Adicionar ao carrinho'
                                : 'Entre para comprar',
                                style: const TextStyle(
                                  fontSize: 18
                                ),
                            ),
                          ),
                        );
                      }, 
                    ),
    
                ],
              ),
            ),
    
    
          ],
        ),
      ),
    );
  }
}