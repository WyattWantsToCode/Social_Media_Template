import 'package:flutter/material.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/user_class.dart';

class StorySection extends StatelessWidget {
  const StorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<User> users = <User>[mockUser1, mockUser2];
    return SizedBox(
      height: 135,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: ((context, index) {
            return StoryButton(
             user: users[index],
            );
            
          })),
    );
  }
}

class StoryButton extends StatefulWidget {
  StoryButton({Key? key, required this.user}) : super(key: key);
  User user;

  @override
  State<StoryButton> createState() => _StoryButtonState();
}

class _StoryButtonState extends State<StoryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(widget.user.profilePictureURL),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(widget.user.name, style: nameStyle.apply(fontSizeFactor: .85),),
          )
        ],
      ),
    );
  }
}