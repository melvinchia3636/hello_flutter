import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:textbook_library/models/book.dart';
import 'package:textbook_library/models/book_list.dart';

Future<BookList>? fetchBooks(String grade) async {
  const String url =
      'https://raw.githubusercontent.com/melvinchia3636/textbookLibrary/main/src/data/v2_books.json';
  final response = await http.get(Uri.parse(url));

  late final List<BookList> bookList;

  if (response.statusCode == 200) {
    final bookListResponse = json.decode(response.body);
    if (bookListResponse is List) {
      bookList = bookListResponse
          .map((e) => BookList.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  } else {
    throw Exception('Failed to load post');
  }

  final books =
      bookList.firstWhere((books) => books.grade == grade).items.map((book) {
    return Book(
      title: book.title,
      id: book.id,
      pageCount: book.pageCount,
      size: book.size,
      thumbnailUrl:
          "https://raw.githubusercontent.com/melvinchia3636/textbooks/main/images/$grade/${book.id}.jpg",
      downloadUrl:
          "https://raw.githubusercontent.com/melvinchia3636/textbooks/main/$grade/${book.id}.pdf",
    );
  }).toList();

  return BookList(grade: grade, items: books);
}
