import 'package:flutter/material.dart';
import '../../models/products.dart';
import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {

  EditProductScreen(Product p) : product = p != null ? p.clone() : Product();
  
  final Product? product;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    print(product!.name);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product!.id != null ? 'Editar anúncio' : 'Criar anúncio'),
        centerTitle: true,
      ),

      body: Form(
        key: formkey,
        child: ListView(
          children: <Widget>[

            ImagesForm(product),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  TextFormField(
                    initialValue: product!.name,
                    decoration: const InputDecoration(
                      hintText: 'Título',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    validator: (name){
                      if (name!.length < 6){
                        return 'Título muito curto';
                      } else {
                        return null;
                      }
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  Text(
                    'R\$ ...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 4),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  TextFormField(
                    initialValue: product!.description,
                    style: const TextStyle(
                      fontSize: 16
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    validator: (desc){
                      if(desc!.length < 10){
                        return 'Descrição muito curta';
                      } else {
                        return null;
                      }
                    },
                  ),

                  SizesForm(product: product),

                  const SizedBox(height: 20,),

                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: (){
                        if(formkey.currentState!.validate()){
                          debugPrint('Válido');
                        } 
                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
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