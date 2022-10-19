import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/create_post_page.dart';
import 'package:social_media_template/colors.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBackground,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.home_filled,
              color: colorIcon,
              size: 32,
            ),
            Icon(
              Icons.search,
              color: colorIcon,
              size: 32,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return CreatePostPage();
                  }));
                },
                child: Icon(
                  Icons.add_box_outlined,
                  color: colorIcon,
                  size: 32,
                ))
          ],
        ),
      ),
    );
  }
}
