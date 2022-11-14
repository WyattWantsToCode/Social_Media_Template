import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_template/Firebase/functions.dart';
import 'package:social_media_template/Firebase/user.dart';
import 'package:social_media_template/Posts/create_post_page.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/UserProfile/user_profile_page.dart';

class TopAppBar extends StatefulWidget {
  TopAppBar({Key? key, required this.scaffoldKey})
      : super(key: key);

  GlobalKey<ScaffoldState> scaffoldKey;

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
              FutureBuilder(
                future: getFriendRequests(auth.currentUser!.displayName!),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    } else if (snapshot.hasData) {
                      return GestureDetector(
                          onTap: () {
                            widget.scaffoldKey.currentState!.openEndDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              (snapshot.data as List<String>).isEmpty
                                  ? Icons.notifications_outlined
                                  : Icons.notifications_active,
                              color: Colors.white,
                              size: 24,
                            ),
                          ));
                    }
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              ),
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
