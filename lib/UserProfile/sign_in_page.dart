import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_template/Firebase/user.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/UserProfile/create_user_page.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/Firebase/firebase.dart';
import 'package:social_media_template/home_page.dart';

import 'package:social_media_template/user_class.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  "Sign In please",
                  style:
                      GoogleFonts.pacifico(color: Colors.white, fontSize: 48),
                )),
                GestureDetector(
                    onTap: () {
                      signInWithGoogle().then((value) async {
                        if (value != null) {
                          if (await doesUserExist(value.uid)) {
                            setCurrentUser(
                                await getUserByID(value.displayName as String));
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: ((context) {
                              return HomePage();
                            })));
                          } else {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: ((context) {
                              return CreateUserPage();
                            })));
                          }
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 75,
                      decoration: BoxDecoration(color: colorDarkGray),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "GOOGLE",
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 36),
                          ),
                        ],
                      ),
                    ))
              ]),
        ),
      ),
    );
  }
}
