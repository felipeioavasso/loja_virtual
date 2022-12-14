import 'package:flutter/material.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:loja_virtual/commom/customdrawer/customdrawer.dart';
import 'package:loja_virtual/models/admin_users_manager.dart';
import 'package:provider/provider.dart';


class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __){
          return AlphabetListScrollView(
            // TODO: verificar o erro dessa lista
            itemBuilder: (_, index){
              return ListTile(
                title: Text(
                  adminUsersManager.users[index].name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white
                  ),
                ),
                subtitle: Text(
                  adminUsersManager.users[index].email!,
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),
              );
            },
            highlightTextStyle: const TextStyle(color: Colors.white),
            indexedHeight: (index) => 80,
            strList: adminUsersManager.names,
            showPreview: true,
          );
        },
      ),
    );
  }
}