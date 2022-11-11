import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_template/Firebase/user.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/UserProfile/sign_in_page.dart';
import 'package:social_media_template/Firebase/firebase.dart';
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

  void checkForUser() async {
    if (auth.currentUser != null) {
      setCurrentUser(await getUserByHandle(auth.currentUser!.displayName!));
    }
  }

  @override
  Widget build(BuildContext context) {
    checkForUser();
    return MaterialApp(
      home: auth.currentUser == null ? SignInPage() : HomePage(),
    );
  }
}
