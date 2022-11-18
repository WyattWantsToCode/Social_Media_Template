import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;

class CameraSection extends StatefulWidget {
  CameraSection({Key? key, required this.cameraControllerClass})
      : super(key: key);
  CameraControllerClass cameraControllerClass;

  @override
  State<CameraSection> createState() => _CameraSectionState();
}

class _CameraSectionState extends State<CameraSection> {
  CameraController? controller;
  bool loading = true;

  @override
  void initState() {
    setCameraController(0);
    widget.cameraControllerClass.function = getPictures;
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
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

  Future<List<XFile>> getPictures() async {
    XFile file1 = await controller!.takePicture();
    setState(() {
      loading = true;
    });
    await controller!.dispose();
    await setCameraController(1);
    XFile file2 = await controller!.takePicture();
    return <XFile>[file1, file2];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: loading
            ? Container(
                child: Text("Hold......"),
              )
            : Column(
                children: [CameraPreview(controller!)],
              ));
  }
}

class CameraControllerClass {
  List<XFile>? pictures;
  Function()? function;
}
