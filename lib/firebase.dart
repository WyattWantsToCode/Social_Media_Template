import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/story_class.dart';
import 'package:social_media_template/user_class.dart';

var db = FirebaseFirestore.instance;

Future<List<String>> getAllPostIDs() async {
  List<String> result = <String>[];
  final ref = db.collection("Posts").doc("all_posts");
  await ref.get().then((value) {
    for (var postID in value.data()!["posts"]) {
      result.add(postID.toString());
    }
    
    return result;
  });
  return result;
}

void addPostToDB(PostClass postClass) {
  db
      .collection("Posts")
      .doc(postClass.ID)
      .set(postToMap(postClass), SetOptions(merge: true));
}

void addPostToAppPosts(String id) async {
  List<String> ids = await getAllPostIDs();
  ids.add(id);
  db.collection("Posts").doc("all_posts").set({"posts": ids});
}

Map<String, dynamic> postToMap(PostClass postClass) {
  return {
    "description": postClass.description,
    "imageURLs": postClass.imageURLs,
    "likes": postClass.likes,
    "user": postClass.user,
    "timeStamp": postClass.timestamp
  };
}

Future<List<PostClass>> getFivePosts(int? seed) async {
  Random random = new Random(seed);
  List<PostClass> posts = <PostClass>[];
  await getAllPostIDs().then((value) async {
    for (int x = 0; x < value.length; x++) {
      int randomIndex = random.nextInt(value.length);
      PostClass post = await getPostByID(value[x]);
      posts.add(post);
      posts.sort(((a, b) {
        return b.timestamp.compareTo(a.timestamp);
      }));
    }
  });
  return posts.sublist(0, 5);
}

Future<PostClass> getPostByID(String id) async {
  final ref = db.collection("Posts").doc(id);
  await ref.get().then((DocumentSnapshot documentSnapshot) {
    mockPost1 = mapToPosstClass(
        documentSnapshot.data() as Map<String, dynamic>, documentSnapshot.id);
  });
  return mockPost1;
}

PostClass mapToPosstClass(Map<String, dynamic> map, String id) {
  List<String> imageURLs = <String>[];
  for (var string in map["imageURLs"]) {
    imageURLs.add(string.toString());
  }
  return PostClass(
      ID: id,
      imageURLs: imageURLs,
      description: map["description"],
      likes: map["likes"],
      user: map["user"],
      timestamp: map["timeStamp"]);
}

Future<User> getUserByHandle(String handle) async {
  final ref = db.collection("Users").doc(handle);
  await ref.get().then((DocumentSnapshot documentSnapshot) {
    mockUser1 =
        mapToUser(documentSnapshot.data() as Map<String, dynamic>, handle);
  });
  return mockUser1;
}

User mapToUser(Map<String, dynamic> map, String handle) {
  return User(
      displayName: map["displayName"],
      handle: handle,
      profilePictureURL: map["profilePictureURL"]);
}

Future<List<PostClass>> getPostFromHandle(String handle) async {
  List<PostClass> posts = <PostClass>[];
  final ref = db.collection("Posts").where("user", isEqualTo: handle);
  await ref.get().then((value) {
    value.docs.forEach((element) {
      posts.add(mapToPosstClass(element.data(), element.id));
    });
  });
  return posts;
}
