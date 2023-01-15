import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textbook_library/api/fetch_books.dart';
import 'package:textbook_library/models/book_list.dart';

final booksProvider = FutureProvider<BookList?>((ref) {
  final grade = ref.watch(selectedGradeProvider);
  return fetchBooks(grade);
});

final selectedGradeProvider = StateProvider<String>((ref) => 'jm1');
