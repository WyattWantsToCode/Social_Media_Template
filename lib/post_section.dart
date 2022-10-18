import 'package:flutter/material.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/firebase.dart';
import 'package:social_media_template/post_class.dart';
import 'package:social_media_template/storage.dart';
import 'package:social_media_template/user_class.dart';

class SpecificPostSection extends StatelessWidget {
  const SpecificPostSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PostClass> posts = <PostClass>[mockPost1, mockPost2, mockPost3];
    return FutureBuilder(
      future: getFivePosts(1234),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            posts = snapshot.data as List<PostClass>;

            return ListView.builder(
                physics: PageScrollPhysics(),
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: ((context, index) {
                  return SpecificPost(post: posts[index]);
                }));
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

class SpecificPost extends StatefulWidget {
  SpecificPost({Key? key, required this.post}) : super(key: key);
  PostClass post;

  @override
  State<SpecificPost> createState() => _SpecificPostState();
}

class _SpecificPostState extends State<SpecificPost> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
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
        ),
        SizedBox(
          height: 500,
          width: double.infinity,
          child: ListView.builder(
            physics: PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.post.imageURLs.length,
            itemBuilder: ((context, index) {
              return FutureBuilder(
                future: getPostImageURL(widget.post.imageURLs[index]),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    } else if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(snapshot.data.toString()),
                                fit: BoxFit.cover)),
                      );
                    }
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: Colors.white,
                ),
              ),
              Text(
                widget.post.likes.toString(),
                style: nameStyle,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.post.description,
            style: nameStyle,
          ),
        )
      ],
    );
  }
}


