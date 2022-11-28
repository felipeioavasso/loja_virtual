import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'item_size.dart';

class Product extends ChangeNotifier {

  String? id;
  String? name;
  String? description;
  List<String>? images;
  List<ItemSize>? sizes;

  ItemSize? _selectedSize;
  ItemSize? get selectedSize => _selectedSize;

  set selectedSize(ItemSize? value){
    _selectedSize = value;
    notifyListeners();
  }

  // Verificar se há estoque do produto
  int? get totalStock{
    int stock = 0;
    for (final size in sizes!){
      stock += size.stock!;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock! > 0;
  }

  // Pegando o menor preço e colocanco no campo preço
  num? get basePrice {
    num lowest = double.infinity;
    for(final size in sizes!){
      if(size.price! < lowest && size.hasStock){
        lowest = size.price!;
      }
    }
    return lowest;
  }

  ItemSize? findSize(String name){
    try {
      return sizes!.firstWhere((s) => s.name == name);
    } catch (e){
      return null;
    }
  }
  
  Product({
    this.id, 
    this.name, 
    this.description, 
    this.images, 
    this.sizes
  }){
    images =images ?? [];
    sizes = sizes ?? [];
  }

  // Método clone
  Product? clone(){
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images!),
      sizes: sizes!.map((size) => size.clone()).toList(),
    );
  }

  Product.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document['name'] as String;
    description = document['descripition'] as String;
    images = List<String>.from(document['images'] as List<dynamic>);
    
    try{
      sizes = (document.get('sizes') as List<dynamic> ).map(
        (s) => ItemSize.fromMap(s as Map<String, dynamic>)).cast<ItemSize>().toList();
    }catch(e){
      sizes = ([]).map(
        (s) => ItemSize.fromMap(s as Map<String, dynamic>)).cast<ItemSize>().toList();
    }

  }

}