import 'package:flutter/material.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/user_class.dart';

class StorySection extends StatelessWidget {
  const StorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<User> users = <User>[mockUser1, mockUser2];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Container(
            width: double.infinity,
            height: .2,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 108,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: ((context, index) {
                return StoryButton(
                  user: users[index],
                  scale: 1,
                );
              })),
        ),
        Container(
          width: double.infinity,
          height: .2,
          color: Colors.grey,
        ),
      ],
    );
  }
}

class StoryButton extends StatefulWidget {
  StoryButton({
    Key? key,
    required this.user,
    this.onPressedFunction,
    this.scale = 1,
  }) : super(key: key);
  User user;
  Function? onPressedFunction;
  double scale;

  @override
  State<StoryButton> createState() => _StoryButtonState();
}

class _StoryButtonState extends State<StoryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: .9,
                child: Container(
                  width: 80 * widget.scale,
                  height: 80 * widget.scale,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.purple,
                          Colors.purple,
                          Colors.pink,
                          Colors.red,
                          Colors.orange,
                          Colors.yellow,
                        ]),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                width: 76 * widget.scale,
                height: 76 * widget.scale,
                decoration: BoxDecoration(
                  color: colorBackground,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 70 * widget.scale,
                height: 70 * widget.scale,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54, width: .5),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(widget.user.profilePictureURL),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              widget.user.displayName,
              style: nameStyle.apply(fontSizeFactor: .75),
            ),
          )
        ],
      ),
    );
  }
}
