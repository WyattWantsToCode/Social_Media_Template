import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_template/BeReals/bereal_class.dart';
import 'package:social_media_template/BeReals/bereal_section.dart';
import 'package:social_media_template/BeReals/create_bereal_page.dart';
import 'package:social_media_template/BeReals/post_bereal_page.dart';
import 'package:social_media_template/Firebase/beReals.dart';
import 'package:social_media_template/Firebase/prompt.dart';
import 'package:social_media_template/Firebase/storage.dart';
import 'package:social_media_template/Firebase/user.dart';
import 'package:social_media_template/Navigation/bottom_bar.dart';
import 'package:social_media_template/Navigation/top_app_bar.dart';
import 'package:social_media_template/UserProfile/user_class.dart';
import 'package:social_media_template/colors.dart';
import 'package:social_media_template/prompt_class.dart';

class BeRealPage extends StatefulWidget {
  BeRealPage({Key? key}) : super(key: key);

  @override
  State<BeRealPage> createState() => _BeRealPageState();
}

class _BeRealPageState extends State<BeRealPage> {
  final key = GlobalKey<ScaffoldState>();

  bool canPost() {
    Timestamp timestampLate = Timestamp.fromDate(
        currentPrompt!.beRealTimestamp.toDate().add(Duration(minutes: 10)));

    print(Timestamp.now().millisecondsSinceEpoch >
        currentPrompt!.beRealTimestamp.millisecondsSinceEpoch);

    if (Timestamp.now().millisecondsSinceEpoch >
            currentPrompt!.beRealTimestamp.millisecondsSinceEpoch &&
        Timestamp.now().millisecondsSinceEpoch <
            timestampLate.millisecondsSinceEpoch) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBeReal,
      key: key,
      body: SafeArea(
          child: Column(
        children: [
          TopAppBar(
            scaffoldKey: key,
            color: colorBeReal,
            label: "RealYou",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.black),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        currentPrompt = await getAllPrompts();
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.refresh_outlined,
                                        color: Colors.white,
                                        size: 32,
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        if (canPost()) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateBeRealPage()));
                                        }
                                      },
                                      child: Icon(
                                        Icons.add_box_outlined,
                                        color: canPost()
                                            ? Colors.white
                                            : Colors.grey,
                                        size: 32,
                                      )),
                                  TextButton(
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 32,
                                      )),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                  Container(
                    width: 10,
                    height: 20,
                  ),
                  BeRealSection(),
                ],
              ),
            ),
          ),
          BottomBar(bottomBarColor: colorBeReal),
        ],
      )),
    );
  }
}

class BeRealSection extends StatelessWidget {
  const BeRealSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          
          FutureBuilder(
            future: getBeReals(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else if (snapshot.hasData) {
                  List<BeReal> beReals = snapshot.data as List<BeReal>;
                  return ListView.builder(
                      physics:
                          PageScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: beReals.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return SpecificBeReal(beReal: beReals[index]);
                      }));
                }
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class SpecificBeReal extends StatefulWidget {
  SpecificBeReal({Key? key, required this.beReal}) : super(key: key);
  BeReal beReal;

  @override
  State<SpecificBeReal> createState() => _SpecificBeRealState();
}

class _SpecificBeRealState extends State<SpecificBeReal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        FutureBuilder(
          future: getUserByID(widget.beReal.user),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else if (snapshot.hasData) {
                User user = snapshot.data as User;
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: BeRealButton(
                          user: user,
                          ringOn: false,
                          nameUnderOne: false,
                          scale: .55,
                        ),
                      ),
                      Text(
                        user.handle,
                        style: nameStyle,
                      )
                    ],
                  ),
                );
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
        FutureBuilder(
            future: getBeRealPicturesURLs(
                widget.beReal.photoURLs[1], widget.beReal.photoURLs[0]),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else if (snapshot.hasData) {
                  List<String> urls = snapshot.data as List<String>;

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: BeRealPictures(
                        image1: DecorationImage(
                            image: NetworkImage(urls[0]), fit: BoxFit.cover),
                        image2: DecorationImage(
                            image: NetworkImage(urls[1]), fit: BoxFit.cover)),
                  );
                }
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            })),
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        Container(
          width: 10,
          height: 20,
        )
      ]),
    );
  }
}
