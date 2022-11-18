import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_media_template/Firebase/prompt.dart';
import 'package:social_media_template/Firebase/user.dart';
import 'package:social_media_template/Navigation/bottom_bar.dart';
import 'package:social_media_template/Navigation/top_app_bar.dart';
import 'package:social_media_template/Posts/create_post_page.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/UserProfile/notifcation_drawer.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/Posts/post_section.dart';
import 'package:social_media_template/BeReals/bereal_section.dart';
import 'package:social_media_template/UserProfile/user_class.dart';
import 'package:social_media_template/prompt_class.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var key = GlobalKey<ScaffoldState>();
  Future<void> refreshPage() {
    return Future.delayed(Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: colorPost,
      endDrawer: NotifactionDrawer(
          userIDs: getFriendRequests(auth.currentUser!.displayName!)),
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          setState(() {});
        }
      },
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TopAppBar(
              scaffoldKey: key,
              color: colorPost,
              label: "Posts",
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return refreshPage();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.black),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    currentPrompt!.postString,
                                    style: stylePrompt,
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                            onPressed: () async {
                                              currentPrompt =
                                                  await getAllPrompts();
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.refresh_outlined,
                                              color: Colors.white,
                                              size: 32,
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => CreatePostPage()));
                                            },
                                            child: Icon(
                                              Icons.add_box_outlined,
                                              color: Colors.white,
                                              size: 32,
                                            )),
                                        TextButton(
                                            onPressed: () {},
                                            child: Icon(
                                              Icons.send,
                                              color: Colors.white,
                                              size: 32,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      Container(
                        width: 10,
                        height: 20,
                      ),
                      SpecificPostSection()
                    ],
                  ),
                ),
              ),
            ),
            BottomBar(
              bottomBarColor: colorPost,
            )
          ],
        ),
      ),
    );
  }
}
