import 'package:social_media_template/post_class.dart';
import 'package:social_media_template/story_class.dart';

class User {
  String displayName;
  String handle;
  String profilePictureURL;
  List<PostClass>? postList;
  List<Story>? storyList;

  User(
      {required this.displayName,
      required this.handle,
      required this.profilePictureURL,
      this.postList,
      this.storyList});
}

class CurrentUser {
  User user;
  List<PostClass> likedPosts;
  List<User> storiesWatched;

  CurrentUser(
      {required this.user,
      required this.likedPosts,
      required this.storiesWatched});
}

CurrentUser currentUser = CurrentUser(
    user: mockUser1,
    likedPosts: <PostClass>[mockPost1],
    storiesWatched: <User>[]);

User mockUser1 = User(
  displayName: "Sammy",
  handle: "sammy",
  profilePictureURL:
      "https://drive.google.com/uc?export=view&id=11rSmO36l7o-V2B5ONLjvDS-nCz7cuNeh",
);

User mockUser2 = User(
    displayName: "Sarah",
    handle: "sarah",
    profilePictureURL:
        "https://drive.google.com/uc?export=view&id=1XWCJACYGtADzEWYAJTs484WTOLveesVY");
