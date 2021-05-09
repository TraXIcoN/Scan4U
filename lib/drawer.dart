import 'package:flutter/material.dart';
import 'package:scan4u/coustom_route.dart';
import 'utilities/qrcode.dart';

class DocDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          color: ThemeData.dark().canvasColor,
          child: Image.asset('lib/Model/images/docIcon.png'),
        ),
        ListTile(
          leading: Icon(Icons.scanner),
          title: Text("Qr Code Scanner"),
          onTap: () {
            Navigator.of(context).pushReplacement(FadePageRoute(
              builder: (context) => QRViewExample(),
            ));
          },
        ),
        ListTile(
          leading: Icon(Icons.money),
          title: Text("Try Premium"),
        ),
        ListTile(
          leading: Icon(Icons.light),
          title: Text("Aura-Map"),
        ),
        ListTile(
          leading: Icon(Icons.photo),
          title: Text("Negative photo Digitalisation"),
        ),
        ListTile(
          leading: Icon(Icons.text_fields),
          title: Text("Changing Handwriting fonts"),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text("About this App"),
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text("Share this App"),
        )
      ],
    ));
  }
}
