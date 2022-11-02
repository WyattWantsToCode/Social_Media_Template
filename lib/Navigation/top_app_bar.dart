import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_template/Posts/create_post_page.dart';
import 'package:social_media_template/UserProfile/user_profile_page.dart';

class TopAppBar extends StatefulWidget {
  TopAppBar({Key? key}) : super(key: key);

  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Social Media",
            style: GoogleFonts.pacifico(
                textStyle: TextStyle(color: Colors.white, fontSize: 22)),
          ),
          Row(
            children: [
              GestureDetector(child:  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return CreatePostPage();
                    })));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                  )),
                  
            ],
          )
        ],
      ),
    );
  }
}
