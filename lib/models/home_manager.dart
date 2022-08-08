import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/section.dart';

class HomeManager extends ChangeNotifier {

  HomeManager(){
    _loadSections();
  }

  List<Section> sections = [];

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _loadSections() async {
    db.collection('home').snapshots().listen((snapshot) { // altera instantaneamente para o cliente quando o adm alterar algo no docs
      sections.clear();
      // Para cada documento em home...
      for (final DocumentSnapshot document in snapshot.docs){
        sections.add(Section.fromDocument(document));
      }
      notifyListeners();
      print(sections);
    });
  }

}