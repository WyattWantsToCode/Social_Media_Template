import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/colors.dart';

class PostFooter extends StatefulWidget {
  PostFooter({Key? key, required this.post}) : super(key: key);
  PostClass post;

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: Colors.white,
                ),
              ),
              Text(
                widget.post.likes.toString(),
                style: nameStyle,
              )
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            widget.post.description,
            style: styleDescription,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            timestampToString(widget.post.timestamp),
            style: styleDateTime,
          ),
        ),
      ],
    );
  }
}

String timestampToString(Timestamp timestamp) {
  Map<int, String> intToMonthMap = {
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "Jun",
    7: "Jul",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };
  Timestamp currentTimeStamp = Timestamp.now();
  int timeDifference = currentTimeStamp.seconds - timestamp.seconds;
  DateTime dateTimeDifference = Timestamp(timeDifference, 0).toDate();

  if (timeDifference < 60) {
    return dateTimeDifference.second.toString() + " seconds ago";
  }

  if (timeDifference < 3600) {
    return dateTimeDifference.minute.toString() + " minutes ago";
  }
  if (timeDifference < 86400) {
    return dateTimeDifference.hour.toString() + " hours ago";
  }

  if (timeDifference < 1209600) {
    return dateTimeDifference.day.toString() + " days ago";
  }

  return intToMonthMap[timestamp.toDate().month].toString() +
      " " +
      timestamp.toDate().day.toString()+ ", " + timestamp.toDate().year.toString();
}
