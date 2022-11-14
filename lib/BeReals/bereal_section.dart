import 'package:flutter/material.dart';
import 'package:social_media_template/Firebase/storage.dart';
import 'package:social_media_template/UserProfile/auth.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/user_class.dart';

class BeRealSection extends StatelessWidget {
  BeRealSection({Key? key, required this.user}) : super(key: key);
  User user;

  @override
  Widget build(BuildContext context) {
    List<User> users = <User>[
      user,
      user,
      user,
      user,
      user,
      user,
      user,
      user,
      user,
      user,
      user,
      user,
    ];
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
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: BeRealButton(
                  user: user,
                  ringOn: false,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: BeRealButton(
                          user: users[index],
                          scale: 1,
                          ringOn: true,
                        ),
                      );
                    })),
              ),
            ],
          ),
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

class BeRealButton extends StatefulWidget {
  BeRealButton({
    Key? key,
    required this.user,
    this.onPressedFunction,
    this.scale = 1,
    required this.ringOn,
    this.nameUnderOne = true,
  }) : super(key: key);
  User user;
  Function? onPressedFunction;
  double scale;
  bool ringOn;
  bool nameUnderOne;

  @override
  State<BeRealButton> createState() => _BeRealButtonState();
}

class _BeRealButtonState extends State<BeRealButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            widget.ringOn
                ? Opacity(
                    opacity: widget.scale < .7? 1 : .9,
                    child: Container(
                      width: widget.scale < .7? 80 * widget.scale + 1 : 80 * widget.scale,
                      height:  widget.scale < .7? 80 * widget.scale + 1 : 80 * widget.scale,
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
                  )
                : Container(),
            Container(
              width: 76 * widget.scale,
              height: 76 * widget.scale,
              decoration: BoxDecoration(
                color: colorBackground,
                shape: BoxShape.circle,
              ),
            ),
            FutureBuilder(
              future: getProfilePictureURL(widget.user.profilePictureURL),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.hasData) {
                    return Container(
                      width: 70 * widget.scale,
                      height: 70 * widget.scale,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white54, width: .5),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data as String),
                              fit: BoxFit.cover)),
                    );
                  }
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            )
          ],
        ),
        widget.nameUnderOne? Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            widget.user.handle,
            style: nameStyle.apply(fontSizeFactor: .75),
          ),
        ): Container(),
      ],
    );
  }
}
