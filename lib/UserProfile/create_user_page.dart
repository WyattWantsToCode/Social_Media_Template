import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/firebase.dart';
import 'package:social_media_template/home_page.dart';
import 'package:social_media_template/user_class.dart';

class CreateUserPage extends StatefulWidget {
  CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  TextEditingController handleController = TextEditingController();
  TextEditingController displatNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackground,
        body: SafeArea(
          child: Center(
            child: Container(
              width: (MediaQuery.of(context).size.width) - 100,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Social Media",
                    style:
                        GoogleFonts.pacifico(fontSize: 48, color: Colors.white),
                  ),
                  Text(
                    "Sign up to see everything you want to see",
                    style: nameStyle,
                  ),
                  createTextField("Handle", handleController),
                  createTextField("Display Name", displatNameController),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GestureDetector(
                      onTap: () async {
                        if (await isHanldleTaken(handleController.text)) {
                        } else {
                          User user = User(
                              displayName: displatNameController.text,
                              handle: handleController.text,
                              profilePictureURL: "Profile_Picture1.jpg",
                              authID: auth.currentUser!.uid);
                          addNewUser(user);
                          setCurrentUser(user);
                          updateAuthDisplayName(user.handle);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                            color: colorDarkGray,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.pacifico(
                                fontSize: 36, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

Widget createTextField(
    String label, TextEditingController textEditingController) {
  return Padding(
    padding: const EdgeInsets.only(top: 30),
    child: TextField(
      cursorColor: Colors.white,
      decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
      style: TextStyle(color: Colors.white, fontSize: 22),
      controller: textEditingController,
    ),
  );
}
