import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:textbook_library/models/book_list.dart';
import 'package:textbook_library/utils/utils.dart';

Future<List<BookList>>? fetchAllBooks() async {
  const String url =
      'https://raw.githubusercontent.com/melvinchia3636/textbookLibrary/main/src/data/v2_books.json';
  final response = await http.get(Uri.parse(url));

  late final List<BookList> bookList;

  if (response.statusCode == 200) {
    final bookListResponse = json.decode(response.body);
    if (bookListResponse is List) {
      bookList = bookListResponse
          .map((e) => BookList.fromJson(e as Map<String, dynamic>))
          .toList()
          .map((books) => BookList(
                items: books.items
                    .map((book) => addURLs(book, books.grade))
                    .toList(),
                grade: books.grade,
              ))
          .toList();
    }
  } else {
    throw Exception('Failed to load post');
  }

  return bookList;
}

Future<BookList>? fetchBooks(String grade) async {
  final List<BookList> bookList = await fetchAllBooks()!;

  final books = bookList.firstWhere((books) => books.grade == grade).items;

  return BookList(grade: grade, items: books);
}
