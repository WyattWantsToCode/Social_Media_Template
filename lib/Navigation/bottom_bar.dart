import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/create_post_page.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/UserProfile/user_profile_page.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/firebase.dart';
import 'package:social_media_template/home_page.dart';
import 'package:social_media_template/user_class.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBackground,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              },
              child: Icon(
                Icons.home_filled,
                color: colorIcon,
                size: 32,
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CreatePostPage();
                  }));
                },
                child: Icon(
                  Icons.add_box_outlined,
                  color: colorIcon,
                  size: 32,
                )),
            TextButton(
              onPressed: () async {
                User user = await getUserByHandle("sarah");
                List<PostClass> posts = await getPostFromHandle("sarah");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) {
                  return UserProfilePage(
                    user: user,
                    posts: posts,
                  );
                })));
              },
              child: Icon(
                Icons.person_outline,
                color: colorIcon,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
