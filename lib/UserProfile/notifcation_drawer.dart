import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:social_media_template/Firebase/storage.dart';
import 'package:social_media_template/Firebase/user.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/user_class.dart';

class NotifactionDrawer extends StatefulWidget {
  NotifactionDrawer({Key? key, required this.userIDs}) : super(key: key);
  Future<List<String>> userIDs;

  @override
  State<NotifactionDrawer> createState() => _NotifactionDrawerState();
}

class _NotifactionDrawerState extends State<NotifactionDrawer> {
  List<String> friendRequestList = <String>[];

  @override
  void initState() {
    asyncInit();
    super.initState();
  }

  void asyncInit() async {
    friendRequestList = await widget.userIDs;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget newFriendRequest(String userID) {
      return GestureDetector(
        onTap: () async {
          removeFriendRequest(currentUser!.user.id, userID);
          currentUser!.user.friendsIDs.add(userID);
          addNewUser(currentUser!.user);
          User user = await getUserByID(userID);
          user.friendsIDs.add(currentUser!.user.id);
          addNewUser(user);

          Navigator.pop(context);
        },
        child: Column(
          children: [
            FutureBuilder(
              future: getUserByID(userID),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.hasData) {
                    User user = (snapshot.data as User);
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          FutureBuilder(
                            future:
                                getProfilePictureURL(user.profilePictureURL),
                            builder: ((context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text("Error"),
                                  );
                                } else if (snapshot.hasData) {
                                  return Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                snapshot.data as String))),
                                  );
                                }
                              }

                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.handle,
                                  style: nameStyle,
                                ),
                                Text(
                                  user.displayName,
                                  style: styleDescription,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
            Container(
              width: double.infinity,
              height: .2,
              color: Colors.white,
            )
          ],
        ),
      );
    }

    List<Widget> list = <Widget>[];
    for (String userID in friendRequestList) {
      list.add(newFriendRequest(userID));
    }
    return Drawer(
      backgroundColor: colorDarkGray,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  "New Friend Requests",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: .2,
              color: Colors.white,
            ),
            ...list
          ],
        ),
      ),
    );
  }
}
