import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_image_picker/multiple_images_selected_page.dart';
import 'package:simple_image_picker/video_selected_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var imagePicker = ImagePicker();
  XFile? selectedPickCamera;
  XFile? selectedPickGallery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Image Picker"),
          leading: Icon(Icons.menu),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                   height: 150,
                  width: 150,
                  child: selectedPickCamera!=null?Image.file(File(selectedPickCamera!.path),fit: BoxFit.cover,):selectedPickGallery!=null?  Image.file(File(selectedPickGallery!.path)):Image.asset("assets/no_img.png",fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.blue
                      ),
                        onPressed: () async {
                        var checkPermission=Permission.camera;
                        if(await checkPermission.isDenied){
                          Fluttertoast.showToast(msg: "Please Permission Allow");
                          checkPermission.request();
                        }
                        if(await checkPermission.isGranted){
                          var image = await imagePicker.pickImage(source: ImageSource.camera);
                          if (image != null) {
                            setState(() {
                              selectedPickCamera = image;
                            });
                          }
                        }
                    }, child: const Row(
                      children: [
                        Icon(Icons.camera_alt_outlined,color: Colors.white,),
                        SizedBox(width: 5,),
                        Text("Camera",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )),
                  ),
                  SizedBox(width: 20,),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                    ),
                        onPressed: () async {
                          var checkPermission=Permission.photos;
                          if(await checkPermission.isDenied){
                            Fluttertoast.showToast(msg: "Please Permission Allow");
                            checkPermission.request();
                          }
                      if(await checkPermission.isGranted){
                        var image = await imagePicker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            selectedPickCamera = image;
                          });
                        }
                        Fluttertoast.showToast(msg: "Please Allow");

                      }

                    }, child: const Row(
                      children: [
                        Icon(Icons.photo,color: Colors.white,),
                        SizedBox(width: 5,),
                        Text("Gallery",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.blue
                    ),
                    onPressed: ()  {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => MultipleImagesSelectedPage(),));
                    }, child: Text("Multiple Images",style: TextStyle(color: Colors.white),),),
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.blue
                    ),
                    onPressed: ()  {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => VideoSelectedPage(),));
                    }, child: Text("Video Pick",style: TextStyle(color: Colors.white),),),
              ),
            ],
          ),
        ));
  }
}
