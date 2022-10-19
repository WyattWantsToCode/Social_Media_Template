import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/colors.dart';

class PostFooter extends StatefulWidget {
  PostFooter({Key? key, required this.post}) : super(key: key);
  PostClass post;

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          padding: const EdgeInsets.all(10),
          child: Text(
            widget.post.description,
            style: nameStyle,
          ),
        )
      ],
    );
  }
}
