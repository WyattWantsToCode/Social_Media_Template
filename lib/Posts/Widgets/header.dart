import 'package:flutter/material.dart';
import 'package:social_media_template/Firebase/post.dart';
import 'package:social_media_template/Firebase/user.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/UserProfile/user_profile_page.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/Firebase/firebase.dart';
import 'package:social_media_template/Firebase/storage.dart';
import 'package:social_media_template/user_class.dart';

class PostHeader extends StatefulWidget {
  PostHeader({Key? key, required this.post}) : super(key: key);
  PostClass post;

  @override
  State<PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<PostHeader> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserByHandle(widget.post.user),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            User user = snapshot.data as User;
            return FutureBuilder(
              future: getProfilePictureURL(user.profilePictureURL),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.hasData) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            List<PostClass> posts =
                                await getPostFromHandle(user.handle);
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return UserProfilePage(user: user, posts: posts);
                            })));
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data as String),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              Text(
                                user.handle,
                                style: nameStyle,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            showMenu(context, widget.post);
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.more_vert_sharp,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            );
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

void showMenu(BuildContext context, PostClass postClass) {
  Widget buttonChoice(IconData iconData, String text, Function() function) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 36,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 36, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: (context),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: colorDarkGray),
          child: Column(
            children: [
              buttonChoice(Icons.delete, "Delete", () {
                removePost(postClass);
                for (var photoID in postClass.imageURLs) {
                  removeImageFromStorage(photoID);
                }
                Navigator.pop(context);
              })
            ],
          ),
        );
      });
}
