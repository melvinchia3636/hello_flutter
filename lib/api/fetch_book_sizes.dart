import 'dart:convert';

import 'package:hello_flutter/models/book_name_response.dart';
import 'package:http/http.dart' as http;

Future<BookNameResponse>? fetchBookNames() async {
  const String url =
      'https://raw.githubusercontent.com/melvinchia3636/scrapeTextbook/main/src/data/sizes.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return BookNameResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}
