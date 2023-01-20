import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textbook_library/api/fetch_books.dart';
import 'package:textbook_library/models/book.dart';

final allBooksProvider = FutureProvider<List<Book>?>((ref) async {
  return fetchAllBooks()?.then((value) {
    return value.map((i) => i.items).expand((i) => i).toList();
  });
});

final searchResultsProvider = FutureProvider<List<Book>?>((ref) async {
  final searchQuery = ref.watch(searchQueryProvider);
  final allBooks = await ref.watch(allBooksProvider.future);

  return searchQuery.isNotEmpty
      ? allBooks
          ?.where(
            (element) => element.title.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
          )
          .toList()
      : [];
});

final searchQueryProvider = StateProvider<String>((ref) => '');
