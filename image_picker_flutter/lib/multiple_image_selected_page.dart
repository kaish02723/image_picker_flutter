import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImageSelectedPage extends StatefulWidget {
  const MultipleImageSelectedPage({super.key});

  @override
  State<MultipleImageSelectedPage> createState() =>
      _MultipleImageSelectedPageState();
}

class _MultipleImageSelectedPageState extends State<MultipleImageSelectedPage> {
  List<XFile> image = [];
  final imagesPicker = ImagePicker();

  Future<void> images() async {
    final List<XFile> multipleImagesSelecte =
        await imagesPicker.pickMultiImage();
    setState(() {
      image.addAll(multipleImagesSelecte);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            children: [
              InkWell( onTap: () {
                images();
              },
                  child: const Icon(Icons.photo)),
              const SizedBox(width: 5,),
              const Text("Gallery"),
            ],
          ),
          leading: Icon(Icons.menu),
        ),
        body: GridView.builder(
          itemCount: image.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Image.file(File(image[index]!.path),fit: BoxFit.cover,),
            );
          },
        ));
  }
}
