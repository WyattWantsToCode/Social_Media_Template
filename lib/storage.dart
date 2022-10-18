import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance;

Future<String> getPostImageURL(String string) async {
  final ref = storage.ref("Posts").child(string);
  var url = await ref.getDownloadURL();
  return url;
}
