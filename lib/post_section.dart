import 'package:flutter/material.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/post_class.dart';

class SpecificPostSection extends StatelessWidget {
  const SpecificPostSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PostClass> posts = <PostClass>[mockPost1, mockPost2, mockPost3];
    return ListView.builder(
        physics: PageScrollPhysics(),
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(
              widget.post.user.name,
              style: nameStyle,
            )
          ],
        ),
        SizedBox(
          height: 500,
          width: double.infinity,
          child: ListView.builder(
            physics: PageScrollPhysics(),

            scrollDirection: Axis.horizontal,
            itemCount: widget.post.imageURLs.length,
            itemBuilder: ((context, index) {
              
              return Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.post.imageURLs[index]),
                        fit: BoxFit.cover)),
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
