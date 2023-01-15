import 'package:json_annotation/json_annotation.dart';
import 'package:textbook_library/models/book.dart';

part 'book_list.g.dart';

@JsonSerializable()
class BookList {
  BookList({
    required this.grade,
    required this.items,
  });

  final String grade;
  final List<Book> items;

  factory BookList.fromJson(Map<String, dynamic> json) =>
      _$BookListFromJson(json);
  Map<String, dynamic> toJson() => _$BookListToJson(this);
}
