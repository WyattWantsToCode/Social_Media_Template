import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_template/Firebase/firebase.dart';
import 'package:social_media_template/user_class.dart';

Future<User> getUserByID(String ID) async {
  User user = mockUser1;
  final ref = db.collection("Users").doc(ID);
  await ref.get().then((value) {
    user = mapToUser(value.data() as Map<String, dynamic>, ID);
  });
  return user;
}

Future<bool> doesUserExist(String authID) async {
  final ref = db.collection("Users").where("authID", isEqualTo: authID);
  bool answer = false;

  await ref.get().then((value) {
    if (value.docs.isNotEmpty) {
      answer = true;
    }
  });
  return answer;
}

Future<bool> isHanldleTaken(String handle) async {
  final ref = db.collection("Users").doc(handle);
  bool answer = false;

  await ref.get().then((value) {
    if (value.data() != null) {
      answer = true;
    }
  });
  return answer;
}

User mapToUser(Map<String, dynamic> map, String id) {
  return User(
      id: id,
      displayName: map["displayName"],
      handle: map["handle"],
      profilePictureURL: map["profilePictureURL"],
      authID: map["authID"]);
}

Future<void> addNewUser(User user) async {
  await db
      .collection("Users")
      .doc(user.id)
      .set(userToMap(user), SetOptions(merge: true));
}

Map<String, dynamic> userToMap(User user) {
  Map<String, dynamic> map = {
    "handle": user.handle,
    "displayName": user.displayName,
    "profilePictureURL": user.profilePictureURL,
    "authID": user.authID
  };
  if (user.followerList != null) {
    map.addAll({"followerList": user.followerList});
  }
  if (user.followingList != null) {
    map.addAll({"followingList": user.followingList});
  }
  return map;
}

Future<void> removeUser(String id) async {
  await db.collection("Users").doc(id).delete();
}
