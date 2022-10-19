import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/post_class.dart';
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        NetworkImage(snapshot.data as String),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Text(
                          user.displayName,
                          style: nameStyle,
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
