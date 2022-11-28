import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/products.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  //const ImagesForm({Key? key, this.product}) : super(key: key);

  const ImagesForm(this.product, {Key? key}) : super(key: key);
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      validator: (images){
        if (images!.isEmpty){
          return 'Insira ao menos uma imagem';
        } else {
          return null;
        }
      },
      initialValue: product!.images!,
      builder: (state){
        void onImageSelected(File file){
          state.value!.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CarouselSlider(
                
                options: CarouselOptions(
                  aspectRatio: 1.0,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                ),

                items: state.value?.map<Widget>((image){
                   return Stack(
                    fit: StackFit.expand,
                     children: <Widget>[
                       
                       if ( image is String)
                         Image.network(image, fit: BoxFit.cover,)
                        else 
                          Image.file(image as File, fit: BoxFit.cover),
                       

                       Align(
                         alignment: Alignment.topRight,
                         child: IconButton(
                           onPressed: (){
                            state.value!.remove(image);
                            state.didChange(state.value);
                           }, 
                           icon: const Icon(Icons.delete),
                           color: Colors.red,
                           iconSize: 40,
                         ),
                       ),

                     ],
                   );
                }).toList()?..add(
                  Material(
                    color: Colors.grey[100],
                    child: SizedBox(
                      width: double.infinity,
                      child: IconButton(
                        onPressed: (){

                          if (Platform.isAndroid) {
                            showModalBottomSheet(
                              context: context, 
                              builder: (_) => ImageSourceSheet(
                                onImageSelected: onImageSelected,
                              ),
                            );
                          } else if (Platform.isIOS) {
                            showCupertinoModalPopup(
                              context: context, 
                              builder: (_) => ImageSourceSheet(
                                onImageSelected: onImageSelected,
                              ), 
                            );
                          }

                        }, 
                        icon: const Icon(Icons.add_a_photo),
                        color: Theme.of(context).primaryColor,
                        iconSize: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            if(state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 16, left: 16),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            
          ],
        );
      },
    );
  }
}