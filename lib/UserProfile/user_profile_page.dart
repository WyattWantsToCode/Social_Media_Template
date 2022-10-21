import 'package:flutter/material.dart';
import 'package:social_media_template/Navigation/bottom_bar.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/Posts/post_section.dart';
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
            
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: getProfilePictureURL(user.profilePictureURL),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
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
                                        image:
                                            NetworkImage(snapshot.data as String))),
                              );
                            }
                          }
            
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          user.displayName,
                          style: nameStyle,
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    physics: PageScrollPhysics(
                      parent: BouncingScrollPhysics()
                    ),
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
