import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  //const SearchDialog(String search, {Key? key, required this.initialText}) : super(key: key);

  const SearchDialog(this.initialText, {Key? key}) : super(key: key);
  final String initialText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        Positioned(
          top: 2,
          left: 4,
          right: 4,          
          child: Card(
            child: TextFormField(
              initialValue: initialText,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (text){
                Navigator.of(context).pop(text);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ),
            ),
          ),

        ),
      ],
    );
  }
}