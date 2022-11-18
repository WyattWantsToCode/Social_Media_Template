import 'package:cloud_firestore/cloud_firestore.dart';

class Prompt {
  String challengeString;
  String postString;
  Timestamp challengeTimestamp;
  Timestamp postTimestamp;
  Timestamp beRealTimestamp;

  Prompt(
      {required this.challengeString,
      required this.postString,
      required this.challengeTimestamp,
      required this.postTimestamp,
      required this.beRealTimestamp});
}

Prompt? currentPrompt;
