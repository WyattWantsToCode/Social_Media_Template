import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/create_post_page.dart';
import 'package:social_media_template/UserProfile/edit_profile_pic.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/storage.dart';
import 'package:social_media_template/user_class.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key, required this.user, required this.imageURL})
      : super(key: key);
  User user;
  String imageURL;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController handleController =
        TextEditingController(text: widget.user.handle);
    TextEditingController displayNameController =
        TextEditingController(text: widget.user.displayName);

    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(children: [
          Container(
            width: double.infinity,
          ),
          EditPageTopNavBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Column(
              children: [
                FutureBuilder(
                  future: getProfilePictureURL(widget.user.profilePictureURL),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      } else if (snapshot.hasData) {
                        return Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(snapshot.data as String))),
                        );
                      }
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EditProfilePicPage(
                          user: widget.user,
                        );
                      })).then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: colorDarkGray,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                            child: Text(
                          "Change Profile Picture",
                          style: styleDescription,
                        ))),
                  ),
                ),
                createTextField("Handle", handleController),
                createTextField("Display Name", displayNameController),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class EditPageTopNavBar extends StatefulWidget {
  EditPageTopNavBar({Key? key}) : super(key: key);

  @override
  State<EditPageTopNavBar> createState() => _EditPageTopNavBarState();
}

class _EditPageTopNavBarState extends State<EditPageTopNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32,
                )),
            Text(
              "Edit Profile",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 32,
                )),
          ]),
    );
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
      style: TextStyle(color: Colors.white, fontSize: 18),
      controller: textEditingController,
    ),
  );
}
