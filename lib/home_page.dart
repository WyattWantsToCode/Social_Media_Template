import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_media_template/Navigation/bottom_bar.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/Posts/post_section.dart';
import 'package:social_media_template/story_section.dart';
import 'package:social_media_template/user_class.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> refreshPage() {
    return Future.delayed(Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: Column(
        children: [
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
                    //StorySection(),
                    Divider(
                      color: Colors.white38,
                    ),
                    SpecificPostSection()
                  ],
                ),
              ),
            ),
          ),
          BottomBar()
        ],
      ),
    );
  }
}
