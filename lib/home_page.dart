import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_media_template/Firebase/user.dart';
import 'package:social_media_template/Navigation/bottom_bar.dart';
import 'package:social_media_template/Navigation/top_app_bar.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/UserProfile/notifcation_drawer.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/Posts/post_section.dart';
import 'package:social_media_template/BeReals/bereal_section.dart';
import 'package:social_media_template/user_class.dart';

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
      backgroundColor: colorBackground,
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
                    children: [BeRealSection(user: currentUser!.user,), SpecificPostSection()],
                  ),
                ),
              ),
            ),
            BottomBar()
          ],
        ),
      ),
    );
  }
}
