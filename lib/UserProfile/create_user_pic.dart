import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/create_post_page.dart';
import 'package:social_media_template/colors.dart';

class CreateUserPicPage extends StatefulWidget {
  CreateUserPicPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPicPage> createState() => _CreateUserPicPageState();
}

class _CreateUserPicPageState extends State<CreateUserPicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
          child: Column(
        children: [
          Row(
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
                  "Edit Profile Picture",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, selectedMediumID);
                    },
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 32,
                    )),
              ]),
          CreatePostSection()
        ],
      )),
    );
  }
}
