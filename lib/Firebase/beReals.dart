import 'package:social_media_template/BeReals/bereal_class.dart';
import 'package:social_media_template/Firebase/firebase.dart';

void addBeRealToDB(BeReal beReal) async {
  final ref = db.collection("BeReals").doc(beReal.id);
  await ref.set(beRealToMap(beReal));
}

Map<String, dynamic> beRealToMap(BeReal beReal) {
  return {
    "photoURLs": beReal.photoURLs,
    "user": beReal.user,
    "timeStamp": beReal.timestamp
  };
}

Future<List<BeReal>> getBeReals() async {
  List<BeReal> beReals = <BeReal>[];
  await db.collection("BeReals").get().then((value) {
    for (var doc in value.docs) {
      beReals.add(mapToBeReal(doc.data(), doc.id));
    }
  });
  return beReals;
}

BeReal mapToBeReal(Map<String, dynamic> map, String id) {
  List<String> list = <String>[];
  for (var string in map["photoURLs"]) {
    list.add(string.toString());
  }
  return BeReal(
      id: id, photoURLs: list, user: map["user"], timestamp: map["timeStamp"]);
}
