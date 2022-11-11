import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:social_media_template/Firebase/post.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/Firebase/firebase.dart';
import 'package:social_media_template/Firebase/storage.dart';
import 'package:social_media_template/user_class.dart';
import 'package:uuid/uuid.dart';

TextEditingController captionController = TextEditingController();
Medium? medium;

class AddCaptionPage extends StatefulWidget {
  AddCaptionPage({Key? key, required this.mediumToPost}) : super(key: key);
  Medium mediumToPost;

  @override
  State<AddCaptionPage> createState() => _AddCaptionPageState();
}

class _AddCaptionPageState extends State<AddCaptionPage> {
  @override
  Widget build(BuildContext context) {
    medium = widget.mediumToPost;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackground,
        body: Column(
          children: [
            TopNavBar(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Image(
                      fit: BoxFit.cover,
                      image:
                          ThumbnailProvider(mediumId: widget.mediumToPost.id),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        maxLines: null,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "Write a caption...",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        style: TextStyle(color: Colors.white),
                        controller: captionController,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopNavBar extends StatefulWidget {
  TopNavBar({Key? key}) : super(key: key);

  @override
  State<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 32,
              )),
          Text(
            "New Post",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          TextButton(
              onPressed: () async {
                final uuid = Uuid();
                String id = uuid.v1();
                PostClass newPost = PostClass(
                    ID: id,
                    imageURLs: <String>[id],
                    description: captionController.text,
                    likes: 0,
                    user: currentUser!.user.handle,
                    timestamp: Timestamp.now());

                addPostToDB(newPost);
                addPhotosToStorage(
                    await compressFile(await medium!.getFile()), id);
                addPostToAppPosts(id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 32,
              ))
        ],
      ),
    );
  }
}
