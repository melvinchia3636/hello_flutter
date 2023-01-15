import 'package:hello_flutter/models/book_sizes.dart';
import 'package:http/http.dart' as http;

Future<Map<String, Map<String, int>?>?> fetchBookSizes() async {
  const String url =
      'https://raw.githubusercontent.com/melvinchia3636/scrapeTextbook/main/src/data/sizes.json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return bookSizesFromJson(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}
