import 'package:flutter/material.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/post_class.dart';

class SpecificPostSection extends StatelessWidget {
  const SpecificPostSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PostClass> posts = <PostClass>[mockPost1, mockPost2, mockPost3];
    return ListView.builder(
      physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: ((context, index) {
          return SpecificPost(post: posts[index]);
        }));
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
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(widget.post.user.profilePictureURL),
                        fit: BoxFit.cover)),
              ),
            ),
            Text(widget.post.user.name, style: nameStyle,)
          ],
        ),
        Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.post.imageURLs[0]),
            fit: BoxFit.cover
          )
        ),)
      ],
    );
  }
}
