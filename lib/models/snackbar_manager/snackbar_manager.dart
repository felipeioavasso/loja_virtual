import 'package:flutter/material.dart';

class SnackbarManager{
  showErro(BuildContext context, String e){
    var snackbar = SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      content: Row(
        children: [
          const Icon(Icons.warning),
          Text(
            e,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}