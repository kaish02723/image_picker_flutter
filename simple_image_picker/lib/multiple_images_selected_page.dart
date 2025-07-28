import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MultipleImagesSelectedPage extends StatefulWidget {
  const MultipleImagesSelectedPage({super.key});

  @override
  State<MultipleImagesSelectedPage> createState() => _MultipleImagesSelectedPageState();
}

class _MultipleImagesSelectedPageState extends State<MultipleImagesSelectedPage> {
var imagePicker=ImagePicker();
 List<XFile> selectedMultipleImage=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            IconButton(onPressed: ()async {
              var checkPermission=Permission.photos;
              if(await checkPermission.isDenied){
                checkPermission.request();
                Fluttertoast.showToast(msg: "Please Permission Allow");
              }
              if(await checkPermission.isGranted){
                var img=await imagePicker.pickMultiImage();
                setState(() {
                  selectedMultipleImage=img;
                });
                Fluttertoast.showToast(msg: "Please Allow");
              }

            }, icon: Icon(Icons.add_circle_outline,size: 30,color: Colors.white,)),
            SizedBox(width: 5,),
            Text("Multiple Image choses",style: TextStyle(fontSize: 16),)
          ],
        ),
      ),
      body: GridView.builder(
        itemCount: selectedMultipleImage.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Image.file(File(selectedMultipleImage[index]!.path),fit: BoxFit.cover,),
            );
        },),
    );
  }
}
