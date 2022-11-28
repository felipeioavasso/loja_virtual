import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/section_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  
  const ItemTile(this.item, {Key? key}) : super(key: key);
  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        debugPrint('tecla apertada');
        if (item.product != null){
          final product = context.read<ProductManager>()
          .findProductByID(item.product!);
          if (product != null){
            Navigator.of(context).pushNamed('/producScreen', arguments: product);
          }
          debugPrint(item.product);
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