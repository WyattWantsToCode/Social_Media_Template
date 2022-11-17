import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:social_media_template/Posts/add_caption.dart';

import 'package:social_media_template/colors.dart';

Medium? selectedMediumID;

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBackground,
        body: Column(
          children: [
            TopNavBar(),
            CreatePostSection(),
          ],
        ),
      ),
    );
  }
}

class CreatePostSection extends StatefulWidget {
  CreatePostSection({Key? key}) : super(key: key);

  @override
  State<CreatePostSection> createState() => _CreatePostSectionState();
}

class _CreatePostSectionState extends State<CreatePostSection> {
  List<Album>? _albums;
  bool loading = false;
  List<DropdownMenuItem<Album>> dropDownItems = [];
  Album? currentAlbum;

  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermission()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      MediaPage imagePage = await albums[0].listMedia();
      Medium firstImageID = imagePage.items.reversed.toList()[0];

      setState(() {
        _albums = albums;
        currentAlbum = albums[0];
        for (Album album in albums) {
          dropDownItems.add(DropdownMenuItem(
            child: Text(album.name.toString()),
            value: album,
          ));
        }
        selectedMediumID = firstImageID;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  Future<bool> _promptPermission() async {
    if (Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  Future<List<Medium>> getMediaPage(Album album) async {
    MediaPage imagepage = await album.listMedia();
    return imagepage.items.reversed.toList();
  }

  void updateSelected(Medium imageProvider) {
    _key.currentState?.setState(() {
      selectedMediumID = imageProvider;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Expanded(
            child: Column(
              children: [
                SelectedImage(
                  key: _key,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButton(
                        dropdownColor: Colors.black,
                        style: TextStyle(fontSize: 22),
                        value: currentAlbum,
                        items: dropDownItems,
                        onChanged: (Album? value) {
                          setState(() {
                            currentAlbum = value;
                          });
                        }),
                  ],
                ),
                FutureBuilder(
                  future: getMediaPage(currentAlbum!),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      } else if (snapshot.hasData) {
                        return MediaGrid(
                          mediumList: snapshot.data as List<Medium>,
                          updateState: updateSelected,
                        );
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

class SelectedImage extends StatefulWidget {
  SelectedImage({Key? key}) : super(key: key);

  @override
  State<SelectedImage> createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Image(
          fit: BoxFit.cover,
          image: PhotoProvider(mediumId: selectedMediumID!.id),
        ));
  }
}

class MediaGrid extends StatefulWidget {
  MediaGrid({Key? key, required this.mediumList, required this.updateState})
      : super(key: key);
  List<Medium> mediumList;
  Function updateState;

  @override
  State<MediaGrid> createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        shrinkWrap: false,
        crossAxisCount: 4,
        children: List.generate(widget.mediumList.length, (index) {
          return GestureDetector(
            onTap: () {
              widget.updateState(widget.mediumList[index]);
            },
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ThumbnailProvider(
                            highQuality: true,
                            mediumId: widget.mediumList[index].id),
                        fit: BoxFit.cover))),
          );
        }),
      ),
    );
  }
}

class TopNavBar extends StatefulWidget {
  TopNavBar({Key? key}) : super(key: key);

  @override
  State<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 32,
              )),
          Text(
            "New Post",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddCaptionPage(mediumToPost: selectedMediumID!);
                }));
              },
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 32,
              ))
        ],
      ),
    );
  }
}
