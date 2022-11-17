import 'package:cloud_firestore/cloud_firestore.dart';

class BeReal {
  String id;
  List<String> photoURLs;
  String user;
  Timestamp timestamp;

  BeReal({required this.id, required this.photoURLs, required this.user, required this.timestamp});
}
