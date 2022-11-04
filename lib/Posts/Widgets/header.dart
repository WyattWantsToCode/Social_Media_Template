import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/UserProfile/user_profile_page.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/firebase.dart';
import 'package:social_media_template/storage.dart';
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
                            List<PostClass> posts = await getPostFromHandle(user.handle);
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return UserProfilePage(
                                  user: user,
                                  posts: posts);
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
                                user.displayName,
                                style: nameStyle,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {}),
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
