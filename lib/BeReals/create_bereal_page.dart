import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:social_media_template/BeReals/post_bereal_page.dart';
import 'package:social_media_template/camera.dart';

class CreateBeRealPage extends StatefulWidget {
  CreateBeRealPage({Key? key}) : super(key: key);

  @override
  State<CreateBeRealPage> createState() => _CreateBeRealPageState();
}

class _CreateBeRealPageState extends State<CreateBeRealPage> {
  CameraControllerClass cameraControllerClass = new CameraControllerClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CameraSection(
              cameraControllerClass: cameraControllerClass,
            ),
            TextButton(
                onPressed: () async {
                  List<XFile> files = await cameraControllerClass.function!();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostBeRealPage(
                              file1: files[0], file2: files[1])));
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                ))
          ],
        ),
      ),
    );
  }
}
