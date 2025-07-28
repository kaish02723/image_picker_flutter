import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'multiple_image_selected_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ImagesPickerPage(),
  ));
}

class ImagesPickerPage extends StatefulWidget {
  @override
  State<ImagesPickerPage> createState() => _ImagesPickerPageState();
}

class _ImagesPickerPageState extends State<ImagesPickerPage> {
  var imagePicker = ImagePicker();

  XFile? selectedImageGallery;
  XFile? selectedImageCamera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: Text(
          "Image Picker",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 250,
                child: selectedImageGallery != null
                    ? Image.file(File(selectedImageGallery!.path),
                        fit: BoxFit.cover)
                    : selectedImageCamera != null
                        ? Image.file(File(selectedImageCamera!.path),
                            fit: BoxFit.cover)
                        : Center(child: Text("No Image Selected")),
              ),
            ),
            SizedBox(
              height: 40,
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () async {
                    final checkPermission = Permission.photos;

                    if (await checkPermission.isDenied) {
                      checkPermission.request();
                    }
                    // if (await checkPermission.isGranted) {
                    //   final image = await imagePicker.pickImage(
                    //       source: ImageSource.gallery);
                    //   if (image != null) {
                    //     setState(() {
                    //       selectedImageGallery = image;
                    //     });
                    //   }
                    // }
                  },
                  child: Text(
                    "Gallery Pick",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () async {
                    final checkPermission = Permission.camera;

                    if (await checkPermission.isDenied) {
                      checkPermission.request();
                    }
                    // if (await checkPermission.isGranted) {
                    //   final image = await imagePicker.pickImage(
                    //       source: ImageSource.camera);
                    //   if (image != null) {
                    //     setState(() {
                    //       selectedImageCamera = image;
                    //     });
                    //   }
                    // }
                  },
                  child: Text(
                    "Camera Pick",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(height: 100,),
            SizedBox(
              height: 40,
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: ()  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MultipleImageSelectedPage(),));
                  },
                  child: Text(
                    "Next Page",
                    style: TextStyle(color: Colors.white),
                  )),
            ),

          ],
        ),
      ),
    );
  }
}
