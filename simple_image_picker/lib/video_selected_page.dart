import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoSelectedPage extends StatefulWidget {
  const VideoSelectedPage({super.key});

  @override
  State<VideoSelectedPage> createState() => _VideoSelectedPageState();
}

class _VideoSelectedPageState extends State<VideoSelectedPage> {
  var imagePicker=ImagePicker();
  XFile? videoSelected;
  VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Video Pick"),
      ),
      body: Column(
        children: [
         SizedBox(
              height: 500,
              width: 400,
              child:videoSelected!=null?VideoPlayer(controller!):Icon(CupertinoIcons.video_camera_solid),
            ),
          SizedBox(height: 50,),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.blue
              ),
              onPressed: ()  async {
                videoSelected=await imagePicker.pickVideo(source: ImageSource.camera);
                controller=VideoPlayerController.file(File(videoSelected!.path));
                  await controller!.initialize();
                  await controller?.play();
                setState(() {

                });

              }, child: Text("video Pick",style: TextStyle(color: Colors.white),),),
          ),
        ],
      ),
    );
  }
}
