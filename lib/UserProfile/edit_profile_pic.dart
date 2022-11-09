import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/create_post_page.dart';
import 'package:social_media_template/UserProfile/edit_profile_page.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/storage.dart';
import 'package:social_media_template/user_class.dart';

class EditProfilePicPage extends StatefulWidget {
  EditProfilePicPage({Key? key, required this.user}) : super(key: key);
  User user;

  @override
  State<EditProfilePicPage> createState() => _EditProfilePicPageState();
}

class _EditProfilePicPageState extends State<EditProfilePicPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
          child: loading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 32,
                              )),
                          Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          TextButton(
                              onPressed: () async {
                                loading = true;
                                setState(() {});
                                removeProfilePicFromStorage(
                                    widget.user.profilePictureURL);
                                await addProfilePictureToStorage(
                                    await compressFile(
                                        await selectedMediumID!.getFile()),
                                    widget.user.profilePictureURL);

                                String string = await getProfilePictureURL(
                                    widget.user.profilePictureURL);
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 32,
                              )),
                        ]),
                    CreatePostSection(),
                  ],
                )),
    );
  }
}
