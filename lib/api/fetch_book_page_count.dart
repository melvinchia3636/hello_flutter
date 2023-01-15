import 'package:hello_flutter/models/book_page_count.dart';
import 'package:http/http.dart' as http;

Future<Map<String, Map<String, int>?>?> fetchBookPageCount() async {
  const String url =
      'https://raw.githubusercontent.com/melvinchia3636/scrapeTextbook/main/src/data/pages.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return bookPageCountFromJson(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}
