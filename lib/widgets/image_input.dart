import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput(this.onSelectImage,{super.key,});

  final Function onSelectImage;
  

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File ? _storedImage;

  // ignore: unused_element
  Future<void>  _takePicture() async{
    
  // ignore: unused_local_variable
  final imageFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
    maxWidth: 600
    );
    if(imageFile ==null){
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
  final appDir = await syspaths.getApplicationDocumentsDirectory();
final fileName = path.basename(imageFile.path);
    // ignore: unused_local_variable
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey),
              ),
            alignment: Alignment.center,
           
            child: _storedImage != null
                ? Image.file  (
                   _storedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : const Text('No Image Taken',textAlign: TextAlign.center,),
                ),
               const SizedBox(
                  width: 10,
                ),
                Expanded(child: 
                ElevatedButton.icon(

                  onPressed: _takePicture,
             
                   icon: const Icon(Icons.camera),
                    label: const Text('Take Picture'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 140, 137, 137)
                    ),
                    )
                )
                 
      ],
    );
  }
}

