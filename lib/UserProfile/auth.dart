import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/user_class.dart' as userClass;

final auth = FirebaseAuth.instance;

userClass.CurrentUser? currentUser;

Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  await auth.signInWithCredential(credential);

  return auth.currentUser;
}

void setCurrentUser(userClass.User user) {
  currentUser = userClass.CurrentUser(
      user: user,
      likedPosts: <PostClass>[],
      storiesWatched: <userClass.User>[]);
}

Future<void> updateAuthDisplayName(String name) async {
  await auth.currentUser!.updateDisplayName(name);
}
