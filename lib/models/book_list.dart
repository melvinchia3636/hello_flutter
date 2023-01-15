import 'package:hello_flutter/models/book.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_list.g.dart';

@JsonSerializable()
class BookList {
  BookList({
    required this.grade,
    required this.books,
  });

  final String grade;
  final List<Book> books;

  factory BookList.fromJson(Map<String, dynamic> json) =>
      _$BookListFromJson(json);
  Map<String, dynamic> toJson() => _$BookListToJson(this);
}
