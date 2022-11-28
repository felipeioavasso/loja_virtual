import 'package:flutter/material.dart';
import 'package:loja_virtual/commom/customdrawer/customdrawer.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:provider/provider.dart';

import 'components/section_list.dart';
import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: const CustomDrawer(),

      body: Stack(
        children: [

          CustomScrollView(
            slivers: <Widget>[

              SliverAppBar( // Appbar flutuante
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Loja do Felipe'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.of(context).pushNamed('/cart'), 
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ]
              ),

              Consumer<HomeManager>(
                builder: (_, homeManager, __){

                  final List<Widget> children = homeManager.sections
                    .map<Widget>((section){ // atentar para o erro do tipo de lista, caso apareça: colocar <Widget> no map
                      switch(section.type){
                        case 'List':
                          return SectionList(section);
                        case 'Staggered':
                          return SectionStaggered(section);
                        default:
                          return Container();
                      }
                    }
                  ).toList();

                  return SliverList(
                  delegate: SliverChildListDelegate(children),
                  );
                }
              ),              

            ],
          ),
        ],
      ),

    );
  }
}