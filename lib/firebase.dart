import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media_template/post_class.dart';
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

Future<List<PostClass>> getFivePosts(int? seed) async {
  Random random = new Random(seed);
  List<PostClass> posts = <PostClass>[];
  await getAllPostIDs().then((value) async {
    for (int x = 0; x < 5; x++) {
      int randomIndex = random.nextInt(value.length);
      PostClass post = await getPostByID(value[randomIndex]);
      posts.add(post);
    }
  });
  return posts;
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
      likes: mockPost1.likes,
      user: map["user"]);
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


