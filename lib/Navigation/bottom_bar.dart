import 'package:flutter/material.dart';
import 'package:social_media_template/Firebase/post.dart';
import 'package:social_media_template/Firebase/user.dart';
import 'package:social_media_template/Posts/create_post_page.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/UserProfile/user_profile_page.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/Firebase/firebase.dart';
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
              User user = await getUserByID(currentUser!.user.id) as User;
              List<PostClass> posts =
                  await getPostFromUserID(currentUser!.user.id);
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
    );
  }
}
