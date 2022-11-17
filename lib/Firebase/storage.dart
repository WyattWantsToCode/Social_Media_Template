import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

final storage = FirebaseStorage.instance;

Future<String> getPostImageURL(String string) async {
  final ref = storage.ref("Posts").child(string);
  var url = await ref.getDownloadURL();
  return url;
}
//https://firebasestorage.googleapis.com/v0/b/social-media-template-4f6b1.appspot.com/o/Posts%2F03eed040-522a-11ed-bdbe-afcc2a9f60ed?alt=media&token=cf9421f5-ec10-4830-aca1-82738791de39

Future<String> getProfilePictureURL(String string) async {
  final ref = storage.ref("Profile_Pictures").child(string);
  var url = await ref.getDownloadURL();
  return url;
}

Future<List<String>> getBeRealPicturesURLs(String id1, String id2) async {
  final ref1 = storage.ref("BeReals").child(id1);
  var url1 = await ref1.getDownloadURL();
  final ref2 = storage.ref("BeReals").child(id2);
  var url2 = await ref2.getDownloadURL();
  return <String>[url1, url2];
}

void addPhotosToStorage(Uint8List uint8list, String id) {
  final ref = storage.ref("Posts").child(id).putData(uint8list);
}

Future<Uint8List> compressFile(File file) async {
  var result = await FlutterImageCompress.compressWithFile(file.absolute.path,
      minWidth: 1080, minHeight: 1080, quality: 50);
  return result!;
}

Future<Uint8List> compressUnit8List(Uint8List uint8list) async {
  var result = await FlutterImageCompress.compressWithList(uint8list,
      minWidth: 1080, minHeight: 1080, quality: 50);
  return result;
}

void removeImageFromStorage(String postID) async {
  final ref = storage.ref("Posts").child(postID);
  await ref.delete();
}

void removeProfilePicFromStorage(String handle) async {
  final ref = storage.ref("Profile_Pictures").child(handle);
  await ref.delete();
}

Future<void> addProfilePictureToStorage(Uint8List uint8list, String id) async {
  final ref = await storage
      .ref("Profile_Pictures")
      .child(id)
      .putData(uint8list)
      .then((p0) {});
}

Future<void> addBeRealPictureToStorage(Uint8List uint8list, String id) async {
  final ref = await storage.ref("BeReals").child(id).putData(uint8list);
}
