import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// Padrão android

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({Key? key, this.onImageSelected}) : super(key: key);

  final Function(File)? onImageSelected;
  final ImagePicker picker = ImagePicker();
  

  Future<void> editImage(String path, BuildContext context) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0), // fixando o recorte em imagens quadradas
      uiSettings: [ 
        AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white
        ),
        IOSUiSettings(
          title: 'Editar Imagem',
          cancelButtonTitle: 'Cancelar',
          doneButtonTitle: 'Concluir',
        ),
      ],
    );
    if (croppedFile != null){
      final File imageFile = File(croppedFile.path);
      onImageSelected!(imageFile);
    }
  } 

  @override
  Widget build(BuildContext context) {

    if (Platform.isAndroid){
      return BottomSheet(
        onClosing: (){},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final XFile? file = (await picker.pickImage(source: ImageSource.camera));
                // ignore: use_build_context_synchronously
                editImage(file!.path, context);
                
              }, 
              child: const Text('Câmera'),
            ),
            ElevatedButton(
              onPressed: () async {
                final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                // ignore: use_build_context_synchronously
                editImage(file!.path, context);
                
              }, 
              child: const Text('Galeria'),
            ),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar foto'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () async {
              final XFile? file = (await picker.pickImage(source: ImageSource.camera));
                // ignore: use_build_context_synchronously
                editImage(file!.path, context);
            }, 
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                // ignore: use_build_context_synchronously
                editImage(file!.path, context);
            }, 
            child: const Text('Galeria'),
          ),
        ],
      );
    }
    
  }
}