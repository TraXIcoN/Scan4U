import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;
  DataBaseService({required this.uid});

  //collection reference
  final CollectionReference videoCollection =
      Firestore.instance.collection('videos');

  Future updateUserData(String video, String name) async {
    return await videoCollection.document(uid).setData({
      'video': video,
      'name': name,
    });
  }
}
