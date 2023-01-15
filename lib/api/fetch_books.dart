import 'package:hello_flutter/api/fetch_book_names.dart';
import 'package:hello_flutter/api/fetch_book_page_count.dart';
import 'package:hello_flutter/api/fetch_book_sizes.dart';
import 'package:hello_flutter/models/book.dart';
import 'package:hello_flutter/models/book_list.dart';

Future<BookList>? fetchBooks(String grade) async {
  final Map<String, Map<String, String>?>? bookNames = await fetchBookNames();
  final Map<String, Map<String, int>?>? bookSizes = await fetchBookSizes();
  final Map<String, Map<String, int>?>? bookPageCount =
      await fetchBookPageCount();

  final Map<String, String>? targetBookNames = bookNames!.entries
      .where((element) => element.key == grade)
      .elementAt(0)
      .value;

  final Map<String, int>? targetBookSizes = bookSizes!.entries
      .where((element) => element.key == grade)
      .elementAt(0)
      .value;

  final Map<String, int>? targetBookPageCount = bookPageCount!.entries
      .where((element) => element.key == grade)
      .elementAt(0)
      .value;

  final List<Book> books = [];

  for (var i = 0; i < targetBookNames!.length; i++) {
    final String id = targetBookNames.keys.elementAt(i);

    books.add(Book(
      id: id,
      title: targetBookNames.entries.elementAt(i).value,
      size: targetBookSizes!.entries.elementAt(i).value,
      pageCount: targetBookPageCount!.entries.elementAt(i).value,
      downloadUrl:
          "https://raw.githubusercontent.com/melvinchia3636/textbooks/main/$grade/$id.pdf",
      thumbnailUrl:
          "https://raw.githubusercontent.com/melvinchia3636/textbooks/main/images/$grade/$id.jpg",
    ));

    print(books[i].thumbnailUrl);
  }

  return BookList(grade: grade, books: books);
}
