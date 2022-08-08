import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loja_virtual/models/products.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  //const ImagesForm({Key? key, this.product}) : super(key: key);

  ImagesForm(this.product);
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product!.images!),
      builder: (state){
        void onImageSelected(File file){
          state.value!.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }
        return AspectRatio(
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
                       icon: const Icon(Icons.remove),
                       color: Colors.red,
                       iconSize: 30,
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
        );
      },
    );
  }
}