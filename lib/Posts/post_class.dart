import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_template/user_class.dart';

class PostClass {
  List<String> imageURLs;
  String ID;
  String description;
  int likes;
  String user;
  Timestamp timestamp;

  PostClass(
      {required this.ID,
      required this.imageURLs,
      required this.description,
      required this.likes,
      required this.user,
      required this.timestamp
      });
}

PostClass mockPost1 = PostClass(
    ID: "qwertyuiop",
    imageURLs: <String>[
      "https://drive.google.com/uc?export=view&id=1wXhVIYQJTxIBaZzT3A4Q2k3Hlokkpcvp",
      "https://drive.google.com/uc?export=view&id=1ayBFm6_RRCCTsMNWMfDzpFZsp5i0VDxO"
    ],
    description: "Loved the mountains this weekend",
    likes: 100,
    user: "mockUser1",
    timestamp: Timestamp.now()
    );

PostClass mockPost2 = PostClass(
    ID: "wertyuiopq",
    imageURLs: <String>[
      "https://drive.google.com/uc?export=view&id=16EcrrtxJkgZ6F4SMv9AAqwwBaYF1Nj25",
    ],
    description: "I am so thankful for this team... they mean the world to me",
    likes: 1200,
    user: "mockUser1",
    timestamp: Timestamp.now()
    );

PostClass mockPost3 = PostClass(
    ID: "ertyuiopqw",
    imageURLs: <String>[
      "https://drive.google.com/uc?export=view&id=15xSw84vkAGezLXamCZM4oHxDRbGupybu",
    ],
    description: "Food... I am better than you",
    likes: 2,
    user: "mockUser2",
    
    timestamp: Timestamp.now());
