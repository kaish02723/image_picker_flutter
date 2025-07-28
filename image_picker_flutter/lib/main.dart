import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyImagePicker(),
  ));
}

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({super.key});

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File? _imageSelected;
  File? _imageSelectedCamera;
  final _picker = ImagePicker();

  pickImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageSelected = File(pickedFile.path);
      });
    }
  }

  pickImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _imageSelectedCamera = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
          title: Text("Image Picker")),
      body: Center(
        child: Column(children: [
          _imageSelected == null
              ? Text("No image selected Gallery")
              : Expanded(
              child: Container(
                height:MediaQuery.of(context).size.height*0.5,
                  child: Image.file(_imageSelected!))
          ),
          _imageSelectedCamera == null
              ? Text("No image selected Camera")
              : Expanded(
              child: Container(
                  height:MediaQuery.of(context).size.height*0.5,
                  child: Image.file(_imageSelectedCamera!))
          ),
        ]),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              pickImageGallery();
            },
            child: Icon(Icons.photo),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            onPressed: () {
              pickImageCamera();
            },
            child: Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
