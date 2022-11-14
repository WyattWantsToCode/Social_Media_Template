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
  List<String> list = <String>[];
  for (var string in map["friendsIDs"]) {
    list.add(string.toString());
  }
  return User(
      id: id,
      displayName: map["displayName"],
      handle: map["handle"],
      profilePictureURL: map["profilePictureURL"],
      authID: map["authID"],
      friendsIDs: list);
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
    "authID": user.authID,
    "friendsIDs": user.friendsIDs
  };
  return map;
}

Future<void> removeUser(String id) async {
  await db.collection("Users").doc(id).delete();
}

void addUserIDToUserEXT(String id, Map<String, dynamic> map) async {
  await db.collection("UsersEXT").doc(id).set(map);
}

Future<Map<String, dynamic>> getUserEXTfromID(String id) async {
  Map<String, dynamic> map = {};
  final ref = await db.collection("UsersEXT").doc(id);
  await ref.get().then((value) {
    if (value != null) {
      map.addAll(value.data()!);
    }
  });
  return map;
}

void sendFriendRequest(String senderID, String receiverID) async {
  Map<String, dynamic> userMap = await getUserEXTfromID(receiverID);
  Map<String, dynamic> friendRequestMap = {};
  if (userMap['friendRequests'] != null) {
    friendRequestMap.addAll(userMap['friendRequests']);
  }
  friendRequestMap[senderID] = Timestamp.now();
  addUserIDToUserEXT(receiverID, {"friendRequests": friendRequestMap});
}

void removeFriendRequest(String userID, String newFriend) async {
  Map<String, dynamic> userMap = await getUserEXTfromID(userID);
  print(userMap);
  Map<String, dynamic> friendRequestMap = userMap["friendRequests"];
  print(friendRequestMap);
  userMap.remove("friendRequests");
  print(userMap);
  friendRequestMap.remove(newFriend);
  print(friendRequestMap);
  userMap.addAll(friendRequestMap);
  print(userMap);
  addUserIDToUserEXT(userID, userMap);
}

Future<List<String>> getFriendRequests(String id) async {
  Map<String, dynamic> map = await getUserEXTfromID(id);
  List<FreindRequest> friendList = <FreindRequest>[];
  List<String> list = <String>[];
  if (map["friendRequests"] != null) {
    (map["friendRequests"]).forEach((key, value) {
      friendList.add(FreindRequest(friendID: key, timestamp: value));
    });
    friendList.sort(
      (FreindRequest a, FreindRequest b) => a.timestamp.compareTo(b.timestamp),
    );
    for (FreindRequest request in friendList) {
      list.add(request.friendID);
    }
  }
  return list;
}

class FreindRequest {
  String friendID;
  Timestamp timestamp;

  FreindRequest({required this.friendID, required this.timestamp});
}
