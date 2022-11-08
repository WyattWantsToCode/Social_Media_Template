import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/UserProfile/sign_in_page.dart';
import 'package:social_media_template/firebase.dart';
import 'package:social_media_template/home_page.dart';
import 'package:social_media_template/user_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Ignore/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: auth.currentUser == null ? SignInPage() : HomePage(),
    );
  }
}
