import 'package:flutter/material.dart';
import 'package:loja_virtual/commom/custom_icon_button.dart';
import 'package:loja_virtual/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize({Key? key, this.size, required this.onRemove, required this.onMoveUp, required this.onMoveDown}) : super(key: key);

  final ItemSize? size;
  final VoidCallback onRemove;
  final dynamic onMoveUp;
  final dynamic onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size!.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            // Validando o tamanho
            validator: (name){
              if(name!.isEmpty){
                return 'Inválido';
              } else {
                return null;
              }
            },
            onChanged: (name) => size!.name = name,
          ),
        ),
        const SizedBox(width: 8),

        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size!.stock?.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock){
              if(int.tryParse(stock!) == null){
                return 'Inválido';
              } else {
                return null;
              }
            },
            onChanged: (stock) => size!.stock = int.tryParse(stock),
          ),
        ),
        const SizedBox(width: 8),

        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size!.price?.toStringAsFixed(2),
            decoration: const InputDecoration(
              labelText: 'Preço',
              prefixText: 'R\$ ',
              isDense: true,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price){
              if(num.tryParse(price!) == null){
                return 'Inválido';
              } else{
                return null;
              }
            },
            onChanged: (price) => size!.price = num.tryParse(price),
          ),
        ),

        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),

        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),

        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        )
      ],
    );
  }
}