import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/story_class.dart';

class User {
  String id;
  String displayName;
  String handle;
  String profilePictureURL;
  String authID;
  List<String>? postList;
  List<String>? followerList;
  List<String>? followingList;

  User(
      {
        required this.id,
        required this.displayName,
      required this.handle,
      required this.profilePictureURL,
      required this.authID,
      this.postList,
      this.followerList,
      this.followingList});
}

class CurrentUser {
  User user;
  List<PostClass>? likedPosts;
  List<User>? storiesWatched;

  CurrentUser({required this.user, this.likedPosts, this.storiesWatched});
}

User mockUser1 = User(
  id: "zxcvbnm",
    displayName: "Sammy",
    handle: "sammy",
    profilePictureURL:
        "https://drive.google.com/uc?export=view&id=11rSmO36l7o-V2B5ONLjvDS-nCz7cuNeh",
    authID: "sdfghjkla");

User mockUser2 = User(
  id: "xcvbnmz",
    displayName: "Sarah",
    handle: "sarah",
    profilePictureURL:
        "https://drive.google.com/uc?export=view&id=1XWCJACYGtADzEWYAJTs484WTOLveesVY",
    authID: "asdfghjkl");
