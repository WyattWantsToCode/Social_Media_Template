import 'package:flutter/material.dart';
import 'package:social_media_template/Posts/post_class.dart';
import 'package:social_media_template/storage.dart';

class PostBody extends StatefulWidget {
  PostBody({
    Key? key, required this.post
  }) : super(key: key);
  PostClass post;

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      width: double.infinity,
      child: ListView.builder(
        physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemCount: widget.post.imageURLs.length,
        itemBuilder: ((context, index) {
          return FutureBuilder(
            future: getPostImageURL(widget.post.imageURLs[index]),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else if (snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    child: Image.network(
                      
                    snapshot.data.toString(),
                    fit: BoxFit.cover,
                    loadingBuilder: ((context, child, loadingProgress) {
                      if(loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator(
                        
                        color: Colors.grey,
                        
                        value: loadingProgress.expectedTotalBytes != null? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! :
                        null
                        ,
                      ),);
                    })
                    ),
                    
                  );
                }
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          );
        }),
      ),
    );
  }
}
