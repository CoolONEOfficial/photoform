import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:photoform/secrets.dart';

class PinImage {
  final int width;
  final int height;
  final Uri url;

  const PinImage({
    required this.width,
    required this.height,
    required this.url,
  });

  factory PinImage.fromJson(Map<String, dynamic> json) {
    return PinImage(
      width: json['width'],
      height: json['height'],
      url: Uri.parse(json['url']),
    );
  }
}

class PinterestService {
  Future<List<PinImage>> scrab() async {
    final response = await http.Client().post(Uri.parse(
      "http://207.254.31.20:8080/?query=test&key=dCfPkgk7iEGDSHe8", //"$apiLink&query=test",
    )); // %20

    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body);

      var pins = list.map((e) => e as Map<String, dynamic>).toList();

      final imgMaps = pins.map((e) {
        return (e["images"] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            PinImage.fromJson(value),
          ),
        );
      });

      return imgMaps.map((e) => e.values.first).toList();
    } else {
      throw Exception("Pinterest request code is not 200");
    }
  }
}
