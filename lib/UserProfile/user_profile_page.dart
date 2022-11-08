import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_template/Navigation/bottom_bar.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/Posts/post_section.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/UserProfile/sign_in_page.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/storage.dart';
import 'package:social_media_template/user_class.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key, required this.user, required this.posts})
      : super(key: key);
  User user;
  List<PostClass> posts;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: colorBackground,
      body: Column(
        children: [
          ProfileTopBar(user: user),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FutureBuilder(
                              future:
                                  getProfilePictureURL(user.profilePictureURL),
                              builder: ((context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Text("Error"),
                                    );
                                  } else if (snapshot.hasData) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  snapshot.data as String))),
                                    );
                                  }
                                }

                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                            ),
                            Column(
                              children: [
                                Text(
                                  user.postList == null
                                      ? "0"
                                      : user.postList!.length.toString(),
                                  style: nameStyle.apply(fontSizeDelta: 5),
                                ),
                                Text(
                                  "Posts",
                                  style:
                                      styleDescription.apply(fontSizeDelta: 0),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  user.followerList == null
                                      ? "0"
                                      : user.followerList!.length.toString(),
                                  style: nameStyle.apply(fontSizeDelta: 5),
                                ),
                                Text(
                                  "Followers",
                                  style:
                                      styleDescription.apply(fontSizeDelta: 0),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  user.followingList == null
                                      ? "0"
                                      : user.followingList!.length.toString(),
                                  style: nameStyle.apply(fontSizeDelta: 5),
                                ),
                                Text(
                                  "Following",
                                  style:
                                      styleDescription.apply(fontSizeDelta: 0),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            user.displayName,
                            style: nameStyle,
                          ),
                        ),
                        Text(
                          "This will be the bio",
                          style: styleDescription,
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      physics:
                          PageScrollPhysics(parent: BouncingScrollPhysics()),
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: ((context, index) {
                        return SpecificPost(post: posts[index]);
                      }))
                ],
              ),
            ),
          ),
          BottomBar()
        ],
      ),
    ));
  }
}

class ProfileTopBar extends StatefulWidget {
  ProfileTopBar({Key? key, required this.user}) : super(key: key);
  User user;
  @override
  State<ProfileTopBar> createState() => _ProfileTopBarState();
}

class _ProfileTopBarState extends State<ProfileTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        child: Row(
          children: [
            TextButton(
              onPressed: (() {
                showUserSelection(context);
              }),
              child: Row(
                children: [
                  Text(
                    widget.user.handle,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.white70,
                      size: 22,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showUserSelection(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(children: [
            TextButton(
                onPressed: () async {
                  await auth.signOut();
                  await GoogleSignIn().signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return SignInPage();
                  }));
                },
                child: Text("Sign Out"))
          ]),
        );
      });
}
