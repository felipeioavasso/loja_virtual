import 'package:flutter/material.dart';
import '../../models/products.dart';
import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  //const EditProductScreen(Product arguments, {Key? key, this.product}) : super(key: key);

  EditProductScreen(this.product);
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Editar anúncio'),
        centerTitle: true,
      ),

      body: ListView(
        children: <Widget>[
          ImagesForm(product),
          
        ],
      ),
    );
  }
}