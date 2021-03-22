import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:scan4u/shared/globals.dart' as globals;

/* class postService {
  Future(String filename, String url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
  }
} */
class Album {
  final int name;
  final String url;

  Album({this.name, this.url});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json[globals.finalName],
      url: json[globals.uploadedFileURL],
    );
  }
}

Future<Album> sendVideo() async {
  final response = await http.post(
    Uri.http('10.0.2.2:8000', '/getVideo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': globals.finalName,
      'url': globals.uploadedFileURL
    }),
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
