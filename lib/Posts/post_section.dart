import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/Widgets/body.dart';
import 'package:social_media_template/Posts/Widgets/footer.dart';
import 'package:social_media_template/Posts/Widgets/header.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/firebase.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/storage.dart';
import 'package:social_media_template/user_class.dart';

class SpecificPostSection extends StatelessWidget {
  const SpecificPostSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PostClass> posts = <PostClass>[mockPost1, mockPost2, mockPost3];
    return FutureBuilder(
      future: getFivePosts(DateTime.now().microsecondsSinceEpoch),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            posts = snapshot.data as List<PostClass>;

            return ListView.builder(
                physics: PageScrollPhysics(
                  parent: BouncingScrollPhysics()
                ),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        PostHeader(post: widget.post),
        PostBody(post: widget.post),
        PostFooter(post: widget.post),
        Divider(color: Colors.white30,)
      ],
    );
  }
}


