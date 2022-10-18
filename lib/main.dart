import 'package:flutter/material.dart';
import 'package:social_media_template/home_page.dart';
import 'package:social_media_template/user_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Ignore/firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: SafeArea(child: HomePage()),
    );
  }
}
