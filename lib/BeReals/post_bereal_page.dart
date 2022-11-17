import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_media_template/BeReals/bereal_class.dart';
import 'package:social_media_template/Firebase/beReals.dart';
import 'package:social_media_template/Firebase/storage.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/colors.dart';
import 'package:uuid/uuid.dart';

class PostBeRealPage extends StatefulWidget {
  PostBeRealPage({Key? key, required this.file1, required this.file2})
      : super(key: key);
  XFile file1;
  XFile file2;

  @override
  State<PostBeRealPage> createState() => _PostBeRealPageState();
}

class _PostBeRealPageState extends State<PostBeRealPage> {
  bool loading = true;
  late Uint8List bytes1;
  late Uint8List bytes2;

  @override
  void initState() {
    asyncInit();
    super.initState();
  }

  void asyncInit() async {
    bytes1 = await widget.file1.readAsBytes();
    bytes2 = await widget.file2.readAsBytes();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
          child: loading
              ? Container()
              : Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 32,
                            )),
                        Text(
                          "New BeReal",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        TextButton(
                            onPressed: () async {
                              var uuid = Uuid();
                              String id1 = uuid.v1();
                              await addBeRealPictureToStorage(await compressUnit8List(bytes1), id1);
                              String id2 = uuid.v1();
                              await addBeRealPictureToStorage(await compressUnit8List(bytes2), id2);
                              addBeRealToDB(BeReal(
                                  id: uuid.v1(),
                                  photoURLs: <String>[id1, id2],
                                  user: currentUser!.user.id,
                                  timestamp: Timestamp.now()));
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 32,
                            ))
                      ],
                    ),
                    BeRealPictures(
                      image1: DecorationImage(
                          image: Image.memory(bytes1).image, fit: BoxFit.cover),
                      image2: DecorationImage(
                          image: Image.memory(bytes2).image, fit: BoxFit.cover),
                    ),
                  ],
                )),
    );
  }
}

class BeRealPictures extends StatefulWidget {
  BeRealPictures({Key? key, required this.image1, required this.image2})
      : super(key: key);
  DecorationImage image1;
  DecorationImage image2;

  @override
  State<BeRealPictures> createState() => _BeRealPicturesState();
}

class _BeRealPicturesState extends State<BeRealPictures> {
  Offset offset = Offset(30, 30);
  GlobalKey stackKey = GlobalKey();

  @override
  void flipPictures() {
    DecorationImage newImage = widget.image1;
    widget.image1 = widget.image2;
    widget.image2 = newImage;
  }

  @override
  Widget build(BuildContext context) {
    Widget draggingWidget = GestureDetector(
      onTap: () {
        setState(() {
          flipPictures();
        });
      },
      child: Container(
        width: 120,
        height: 120 * 1.8,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: widget.image1),
      ),
    );

    return Stack(
      key: stackKey,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 1.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: widget.image2),
            ),
          ],
        ),
        Positioned(
          top: offset.dy,
          left: offset.dx,
          child: Draggable(
            feedback: draggingWidget,
            child: draggingWidget,
            childWhenDragging: Container(),
            onDragStarted: (() {
              print("started");
            }),
            onDragEnd: (details) {
              
              final RenderBox renderBox =
                  stackKey.currentContext!.findRenderObject() as RenderBox;
              final pos = renderBox.localToGlobal(Offset.zero);
              final size = renderBox.size;
              
              
                Offset newOffset = details.offset - pos;

                setState(() {
                
                  
                  if (newOffset.dx < 0) {
                    newOffset = Offset(30, newOffset.dy);
                  }
                  if (newOffset.dy < 0) {
                    newOffset = Offset(newOffset.dx, 30);
                  }
                  if (newOffset.dx > size.width - 120) {
                    newOffset = Offset(size.width - 120 - 30, newOffset.dy);
                  }
                  if (newOffset.dy > size.height - 120 * 1.8) {
                    newOffset =
                        Offset(newOffset.dx, size.height - 120 * 1.8 - 30);
                  }
                  offset = newOffset;
                });
              
            },
          ),
        ),
      ],
    );
  }
}
