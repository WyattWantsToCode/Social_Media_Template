import 'package:social_media_template/user_class.dart';

class PostClass {
  List<String> imageURLs;
  String description;
  int likes;
  User user;

  PostClass(
      {required this.imageURLs,
      required this.description,
      required this.likes,
      required this.user});
}

PostClass mockPost1 = PostClass(imageURLs: <String>[
  "https://drive.google.com/uc?export=view&id=1wXhVIYQJTxIBaZzT3A4Q2k3Hlokkpcvp",
  "https://drive.google.com/uc?export=view&id=1ayBFm6_RRCCTsMNWMfDzpFZsp5i0VDxO"
], description: "Loved the mountains this weekend", likes: 100, user: mockUser1);

PostClass mockPost2 = PostClass(
    imageURLs: <String>[
      "https://drive.google.com/uc?export=view&id=16EcrrtxJkgZ6F4SMv9AAqwwBaYF1Nj25",
    ],
    description: "I am so thankful for this team... they mean the world to me",
    likes: 1200, user: mockUser1);

PostClass mockPost3 = PostClass(imageURLs: <String>[
  "https://drive.google.com/uc?export=view&id=1bWw_Q4wvupbgrLRId6Khq5ogg-A8X8pi",
], description: "Food... I am better than you", likes: 2, user: mockUser2);
