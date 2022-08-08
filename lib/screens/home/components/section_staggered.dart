import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_virtual/screens/home/components/section_header.dart';
import '../../../models/section.dart';
import 'item_tile.dart';

class SectionStaggered extends StatelessWidget { 

  const SectionStaggered(this.section);
  final Section? section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SectionHeader(section!),

          StaggeredGridView.countBuilder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            mainAxisSpacing: 4,
            crossAxisCount: 4,
            itemCount: section!.items!.length, 
            itemBuilder: (_, index){
              return ItemTile(
                section!.items![index]
              );
            },  
            staggeredTileBuilder: (index) => StaggeredTile.count(
              2, index.isEven ? 2 : 1
            ),          
          ),


        ],
      ),
    );
  }
}