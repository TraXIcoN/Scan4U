import 'dart:io';

import 'package:scan4u/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  File _cameraImage;
  File _video;
  File _cameraVideo;
  String secondButtonText = 'Record video';

  final AuthService _auth = AuthService();

  ImagePicker picker = ImagePicker();

  VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;

  Future uploadFile(pickedFile) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('videos/${Path.basename(pickedFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        var _uploadedFileURL = fileURL;
      });
    });
  }

  // This funcion will helps you to pick and Image from Gallery
  _pickImageFromGallery() async {
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    File image = File(pickedFile.path);

    setState(() {
      _image = image;
    });
  }

  // This funcion will helps you to pick and Image from Camera
  _pickImageFromCamera() async {
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    File image = File(pickedFile.path);

    setState(() {
      _cameraImage = image;
    });
  }

  // This funcion will helps you to pick a Video File
  _pickVideo() async {
    var pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    _video = File(pickedFile.path);

    /* _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      }); */
    uploadFile(_video);
  }

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile.path);
    GallerySaver.saveVideo(pickedFile.path).then((bool success) {
      setState(() {
        secondButtonText = 'video saved!';
      });
    });
    print(uploadFile(pickedFile));

    /* _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)
      ..initialize().then((_) {
        setState(() {});
        _cameraVideoPlayerController.play();
      }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Image / Video Picker"),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Logout'))
          ]),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                if (_image != null)
                  Image.file(_image)
                else
                  Text(
                    "Click on Pick Image to select an Image",
                    style: TextStyle(fontSize: 18.0),
                  ),
                RaisedButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  child: Text("Pick Image From Gallery"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                if (_cameraImage != null)
                  Image.file(_cameraImage)
                else
                  Text(
                    "Click on Pick Image to select an Image",
                    style: TextStyle(fontSize: 18.0),
                  ),
                RaisedButton(
                  onPressed: () {
                    _pickImageFromCamera();
                  },
                  child: Text("Pick Image From Camera"),
                ),
                if (_video != null)
                  _videoPlayerController.value.initialized
                      ? AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController),
                        )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                RaisedButton(
                  onPressed: () {
                    _pickVideo();
                  },
                  child: Text("Pick Video From Gallery"),
                ),
                if (_cameraVideo != null)
                  _cameraVideoPlayerController.value.initialized
                      ? AspectRatio(
                          aspectRatio:
                              _cameraVideoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_cameraVideoPlayerController),
                        )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                RaisedButton(
                  onPressed: () {
                    _pickVideoFromCamera();
                  },
                  child: Text(secondButtonText),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
