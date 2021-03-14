import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';


ImagePicker picker = ImagePicker();

class DataBaseService{

  //collection reference
  final CollectionReference videoCollection = Firestore.instance.collection('videos');

  Future updateUserData()

}

Future uploadToStorage() async {
try {
  final DateTime now = DateTime.now();
  final int millSeconds = now.millisecondsSinceEpoch;
  final String month = now.month.toString();
  final String date = now.day.toString();
  final String storageId = (millSeconds.toString() + uid);
  final String today = ('$month-$date'); 

  final PickedFile file = await picker.getVideo(source: ImageSource.camera);


  StorageReference ref = FirebaseStorage.instance.ref().child("video").child(today).child(storageId);
  StorageUploadTask uploadTask = ref.putFile(await file, StorageMetadata(contentType: 'video/mp4'));

  Uri downloadUrl = (await uploadTask.future).downloadUrl;

    final String url = downloadUrl.toString();

 print(url);

} catch (error) {
  print(error);
  }

}