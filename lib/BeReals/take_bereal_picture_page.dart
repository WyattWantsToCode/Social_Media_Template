import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:social_media_template/BeReals/post_bereal_page.dart';
import 'package:social_media_template/colors.dart';

late List<CameraDescription> cameras;

class TakeBeRealPage extends StatefulWidget {
  TakeBeRealPage({Key? key}) : super(key: key);

  @override
  State<TakeBeRealPage> createState() => _TakeBeRealPageState();
}

class _TakeBeRealPageState extends State<TakeBeRealPage> {
  CameraController? controller;

  bool loading = true;

  void initState() {
    setCameraController(0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> setCameraController(int number) async {
    controller = CameraController(cameras[number], ResolutionPreset.max);
    await controller!.initialize().then((value) {
      setState(() {
        loading = false;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackground,
        body: SafeArea(
            child: loading
                ? Container(
                    child: Center(
                        child: Text(
                      "Hold Still... Sorry",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    )),
                  )
                : Column(
                    children: [
                      CameraPreview(controller!),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () async {
                                XFile file1 = await controller!
                                    .takePicture()
                                    .then((value) {
                                  setState(() {
                                    loading = true;
                                  });
                                  return value;
                                });

                                controller = CameraController(
                                    cameras[1], ResolutionPreset.max);
                                await controller!.initialize().then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                });

                                XFile file2 = await controller!.takePicture();

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PostBeRealPage(
                                      file1: file1, file2: file2);
                                }));
                              },
                              child: Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                              ))
                        ],
                      )
                    ],
                  )));
  }
}
