import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/products.dart';
import 'package:loja_virtual/models/section_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  
  ItemTile(this.item);
  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('tecla apertada');
        if (item.product != null){
          final product = context.read<ProductManager>()
          .findProductByID(item.product!);
          if (product != null){
            Navigator.of(context).pushNamed('/producScreen', arguments: product);
          }
          print(item.product);
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        // Suavizando a abertura das imagens
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage, 
          image: item.image!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}