import 'package:flutter/material.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:loja_virtual/screens/home/components/item_tile.dart';
import 'package:loja_virtual/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {
  //const SectionList({Key? key, this.section}) : super(key: key);

  const SectionList(this.section);
  final Section? section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SectionHeader(section!),

          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index){
                return ItemTile(
                  section!.items![index]
                );
              }, 
              separatorBuilder: (_, __) => const SizedBox(width: 4,), 
              itemCount: section!.items!.length,
            ),
          )



        ],
      ),
    );
  }
}