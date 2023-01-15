import 'package:hello_flutter/models/book_names.dart';
import 'package:http/http.dart' as http;

Future<Map<String, Map<String, String>?>?>? fetchBookNames() async {
  const String url =
      'https://raw.githubusercontent.com/melvinchia3636/scrapeTextbook/main/src/data/name.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return bookNamesFromJson(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}
