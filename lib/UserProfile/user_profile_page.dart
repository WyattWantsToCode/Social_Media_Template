import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_template/Firebase/post.dart';
import 'package:social_media_template/Navigation/bottom_bar.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/Posts/post_section.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/UserProfile/edit_profile_page.dart';
import 'package:social_media_template/UserProfile/sign_in_page.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/Firebase/storage.dart';
import 'package:social_media_template/user_class.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key? key, required this.user, required this.posts})
      : super(key: key);
  User user;
  List<PostClass> posts;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User? result;

  @override
  Widget build(BuildContext context) {
    if (result != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return UserProfilePage(user: result as User, posts: widget.posts);
      }));
    }
    print(result);
    return SafeArea(
        child: Scaffold(
      backgroundColor: colorBackground,
      body: Column(
        children: [
          ProfileTopBar(user: widget.user),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FutureBuilder(
                              future: getProfilePictureURL(
                                  widget.user.profilePictureURL),
                              builder: ((context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Text("Error"),
                                    );
                                  } else if (snapshot.hasData) {
                                    return Container(
                                      width: 90,
                                      height: 90,
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
                                  widget.posts.length.toString(),
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
                                  widget.user.followerList == null
                                      ? "0"
                                      : widget.user.followerList!.length
                                          .toString(),
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
                                  widget.user.followingList == null
                                      ? "0"
                                      : widget.user.followingList!.length
                                          .toString(),
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
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            widget.user.displayName,
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
                  currentUser!.user.id == widget.user.id
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () async {
                              String imageURL = await getProfilePictureURL(
                                  widget.user.profilePictureURL);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EditProfilePage(
                                  user: widget.user,
                                  imageURL: imageURL,
                                );
                              })).then((value) async {
                                if (value != null) {
                                  List<PostClass> posts =
                                      await getPostFromUserID(
                                          (value as User).id);

                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UserProfilePage(
                                        user: value as User, posts: posts);
                                  }));
                                } else {
                                  setState(() {});
                                }
                              });
                            },
                            child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: colorDarkGray),
                                child: Center(
                                  child: Text(
                                    "Edit Profile",
                                    style: styleDescription,
                                  ),
                                )),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: double.infinity,
                      height: .2,
                      color: Colors.grey,
                    ),
                  ),
                  ListView.builder(
                      physics:
                          PageScrollPhysics(parent: BouncingScrollPhysics()),
                      shrinkWrap: true,
                      itemCount: widget.posts.length,
                      itemBuilder: ((context, index) {
                        return SpecificPost(post: widget.posts[index]);
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
