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
Future<http.Response> createAlbum() {
  http.post(
    Uri.http('10.0.2.2:8000', '/getVideo/aditya/mohan'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': globals.finalName,
      'fileUrl': globals.uploadedFileURL
    }),
  );
  return null;
}
