import 'package:flutter/material.dart';
import 'package:loja_virtual/commom/customdrawer/customdrawer.dart';
import 'package:loja_virtual/screens/products/components/product_list_tile.dart';
import 'package:provider/provider.dart';

import '../../models/product_manager.dart';
import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager,__){
            if (productManager.search.isEmpty){
              return const Text('Produtos');
            }else {
              return LayoutBuilder(
                builder: (_, constraints){
                  constraints.biggest.width;
                  return  GestureDetector(
                    onTap: () async {
                    final search = await showDialog<String>(
                        context: context, 
                        builder: (_) => SearchDialog(
                          productManager.search
                        ),
                      );
                    if (search != null){
                        productManager.search = search;
                      }
                    },
                    child: Container(
                      width: constraints.biggest.width,
                      child: Text(productManager.search,
                      textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          
          Consumer<ProductManager>(
            builder: (_, productManager, __){
              if (productManager.search.isEmpty) {
                //------------ Sistema de busca
                return IconButton( 
                  onPressed: () async {
                    final search = await showDialog<String>(
                      context: context, 
                      builder: (_) => SearchDialog(productManager.search),
                    );
                    if (search != null){
                      productManager.search = search;
                    }
                  }, 
                  icon: const Icon(Icons.search)
                );
              } else {
                return IconButton( 
                  onPressed: () async {
                    
                    productManager.search = '';
                    
                  }, 
                  icon: const Icon(Icons.close)
                );
              }
            }
          ),
          
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, ProductManager, __){
          final filteredProducts = ProductManager.filteredProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: ProductManager.filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(
                product: ProductManager.filteredProducts[index],
              );
            }, 
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('/cart');
        },
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.shopping_cart), 
      ),
    );
  }
}