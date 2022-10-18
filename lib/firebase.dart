import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_template/post_class.dart';

var db = FirebaseFirestore.instance;

Future<List<String>> getAllPostIDs() async {
  List<String> result = <String>[];
  final ref = db.collection("Posts").doc("all_posts");
  ref.get().then((value) {
    for (var postID in value.data()!["posts"]) {
      result.add(postID.toString());
    }
    return result;
  });
  return (result);
}

