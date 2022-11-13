import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:social_media_template/Firebase/storage.dart';
import 'package:social_media_template/Firebase/user.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/UserProfile/create_user_pic.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/Firebase/firebase.dart';
import 'package:social_media_template/home_page.dart';
import 'package:social_media_template/user_class.dart';
import 'package:uuid/uuid.dart';

class CreateUserPage extends StatefulWidget {
  CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  TextEditingController handleController = TextEditingController();
  TextEditingController displatNameController = TextEditingController();
  Medium? medium;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackground,
        body: SafeArea(
          child: SingleChildScrollView(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            image: medium != null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: PhotoProvider(mediumId: medium!.id))
                                : null),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: (() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CreateUserPicPage();
                          })).then((value) {
                            setState(() {
                              medium = value;
                            });
                          });
                        }),
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: colorDarkGray,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                                child: Text(
                              "Change Profile Picture",
                              style: nameStyle,
                            ))),
                      ),
                    ),
                    createTextField("Handle", handleController),
                    createTextField("Display Name", displatNameController),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GestureDetector(
                        onTap: () async {
                          if (medium != null) {
                            if (await isHanldleTaken(handleController.text)) {
                            } else {
                              final rand = Uuid();
                              String id = rand.v1();
                              User user = User(
                                  id: id,
                                  displayName: displatNameController.text,
                                  handle: handleController.text,
                                  profilePictureURL: id,
                                  authID: auth.currentUser!.uid);
                              addNewUser(user);
                              setCurrentUser(user);
                              updateAuthDisplayName(user.id);
                              addProfilePictureToStorage(
                                  await compressFile(await medium!.getFile()),
                                  user.profilePictureURL);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomePage();
                              }));
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: colorDarkGray,
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.pacifico(
                                  fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
