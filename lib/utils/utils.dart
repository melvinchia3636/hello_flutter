import 'package:textbook_library/models/book.dart';

Book addURLs(Book book, String grade) {
  return Book(
    title: book.title,
    id: book.id,
    pageCount: book.pageCount,
    size: book.size,
    grade: grade,
    thumbnailUrl:
        "https://raw.githubusercontent.com/melvinchia3636/textbooks/main/images/$grade/${book.id}.jpg",
    downloadUrl:
        "https://raw.githubusercontent.com/melvinchia3636/textbooks/main/$grade/${book.id}.pdf",
  );
}
