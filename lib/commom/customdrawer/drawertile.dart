import 'package:flutter/material.dart';
import 'package:loja_virtual/models/pagemanager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  //const DrawerTile({Key? key}) : super(key: key);

  late final IconData? iconData;
  late final String title;
  late final int? page;

  DrawerTile({Key? key, required this.iconData, required this.title, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final int curPage = context.watch<PageManeger>().page;
    final Color primaryColor = Theme.of(context).primaryColor;


    return InkWell(
      onTap: (){
        context.read<PageManeger>().setPage(page!);
      },
      child: SizedBox(
        height: 80,
        child: Row(
          
          children: <Widget>[
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 20,
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
    
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page ? primaryColor : Colors.grey[700]
              ),
            ),

          ],
        ),
      ),
    );
  }
}