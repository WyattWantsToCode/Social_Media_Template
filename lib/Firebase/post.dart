import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_template/Firebase/firebase.dart';
import 'package:social_media_template/Posts/post_class.dart';

Future<List<String>> getAllPostIDs() async {
  List<String> result = <String>[];
  final ref = db.collection("Posts");
  await ref.get().then((value) {
    for (var doc in value.docs) {
      result.add(doc.id);
    }

    return result;
  });
  return result;
}

Future<void> addPostToDB(PostClass postClass) async {
  await db
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
  List<PostClass> posts = <PostClass>[];
  await getAllPostIDs().then((value) async {
    for (int x = 0; x < value.length; x++) {
      PostClass post = await getPostByID(value[x]);
      posts.add(post);
      posts.sort(((a, b) {
        return b.timestamp.compareTo(a.timestamp);
      }));
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
      likes: map["likes"],
      user: map["user"],
      timestamp: map["timeStamp"]);
}

Future<List<PostClass>> getPostFromUserID(String id) async {
  List<PostClass> posts = <PostClass>[];
  final ref = db.collection("Posts").where("user", isEqualTo: id);
  await ref.get().then((value) {
    value.docs.forEach((element) {
      posts.add(mapToPosstClass(element.data(), element.id));
    });
    posts.sort(((a, b) {
      return b.timestamp.compareTo(a.timestamp);
    }));
  });
  return posts;
}

void removePost(PostClass postClass) async {
  List<String> ids = await getAllPostIDs();
  ids.remove(postClass.ID);
  db.collection("Posts").doc("all_posts").set({"posts": ids});
  db.collection("Posts").doc(postClass.ID).delete();
}

Future<void> updateUsersPostToNewHandle(
    String oldHandle, String newHandle) async {
  List<PostClass> allPosts = await getPostFromUserID(oldHandle);
  for (PostClass postClass in allPosts) {
    postClass.user = newHandle;
    await addPostToDB(postClass);
  }
  return null;
}
