import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:io';
import 'package:scan4u/services/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scan4u/services/post.dart';
import 'package:scan4u/shared/file_extension.dart';
import 'package:scan4u/shared/globals.dart' as globals;
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(4, 0.8),
];

List<Widget> _tiles = <Widget>[
  _Example01Tile(Colors.blueGrey.shade900, Icons.widgets),
  _Example02Tile(Colors.blueGrey.shade900, Icons.wifi),
  _Example03Tile(Colors.blueGrey.shade900, Icons.panorama_wide_angle),
  _Example04Tile(Colors.blueGrey.shade900, Icons.map),
  _Example05Tile(Colors.blueGrey.shade900, Icons.send),
];

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Example01(),
    );
  }
}

class Example01 extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<Example01> {
  File _image;
  File _cameraImage;
  File _video;
  File _cameraVideo;
  File sampleVideo;
  File temp;
  String secondButtonText = 'Record video';
  String fileName = '';

  final AuthService _auth = AuthService();

  ImagePicker picker = ImagePicker();

  VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;

  Future getVideo() async {
    PickedFile tempVideo =
        await ImagePicker().getVideo(source: ImageSource.gallery);
    temp = File(tempVideo.path);
    this.sampleVideo = temp;
    globals.sampleVideo = sampleVideo;
    final fileName = await AppUtil.getFileNameWithExtension(this.sampleVideo);
    globals.finalName = fileName.replaceAll(".jpg", ".mp4");
    print(globals.finalName);
  }

  // This funcion will helps you to pick and Image from Gallery
  pickImageFromGallery() async {
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    File image = File(pickedFile.path);
    this._image = image;
  }

  // This funcion will helps you to pick and Image from Camera
  pickImageFromCamera() async {
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    File image = File(pickedFile.path);
    this._cameraImage = image;
  }

  // This funcion will helps you to pick a Video File
  pickVideo() async {
    /* _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      }); */
    final fileName = await AppUtil.getFileNameWithExtension(sampleVideo);
    globals.finalName = fileName.replaceAll(".jpg", ".mp4");
    print(globals.finalName);
  }

  // This funcion will helps you to pick a Video File from Camera
  pickVideoFromCamera() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile.path);
    GallerySaver.saveVideo(pickedFile.path).then((bool success) {
      setState(() {
        secondButtonText = 'video saved!';
      });
    });
    /* _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)
      ..initialize().then((_) {
        setState(() {});
        _cameraVideoPlayerController.play();
      }); */
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.grey,
        appBar: new AppBar(
          title: new Text('Home'),
          backgroundColor: Colors.black38,
        ),
        body: new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _staggeredTiles,
              children: _tiles,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
            )));
  }
}

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  MyHomePageState().pickImageFromGallery();
                },
                child: Text(
                  "Pick Image From Gallery",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Example02Tile extends StatelessWidget {
  const _Example02Tile(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  MyHomePageState().pickImageFromCamera();
                },
                child: Text(
                  "Pick Image From Camera",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Example03Tile extends StatelessWidget {
  const _Example03Tile(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  MyHomePageState().getVideo();
                  //MyHomePageState().pickVideo();
                },
                child: Text(
                  "Pick Video From Gallery",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Example04Tile extends StatelessWidget {
  const _Example04Tile(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  MyHomePageState().pickVideoFromCamera();
                },
                child: Text(
                  'Pick Video From Camera',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Example05Tile extends StatefulWidget {
  const _Example05Tile(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  __Example05TileState createState() => __Example05TileState();
}

class __Example05TileState extends State<_Example05Tile> {
  final AuthService _auth = AuthService();
  upload() async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child(globals.finalName);
    final StorageUploadTask uploadTask =
        storageReference.putFile(globals.sampleVideo);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        globals.uploadedFileURL = fileURL;
        print(globals.uploadedFileURL);
      });
    });
    await _auth.databaseIntegrate();
    await sendVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  upload();
                },
                child: Text(
                  'Upload',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
