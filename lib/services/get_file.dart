import 'dart:io';

import 'package:http/http.dart' as http;

Future get_file() async {
  final String _localPath = "/../assets/";
  final String pdfUrl = r"M:\TEPROJECT\CamScannerClone\scanfinal\data";
  final File file = File('${_localPath}output.pdf');
  try {
    http.Response response = await http.get(
      '$pdfUrl',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    await file.writeAsBytes(response.bodyBytes);
  } catch (e) {
    print(e);
  }
}
