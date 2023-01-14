import 'package:hello_flutter/models/g_book.dart';
import "package:json_annotation/json_annotation.dart";

part "g_books.g.dart";

@JsonSerializable()
class GBooks {
  const GBooks({
    required this.kind,
    required this.totalItems,
    required this.items,
  });

  final String kind;
  final int totalItems;
  final List<GBook> items;

  factory GBooks.fromJson(Map<String, dynamic> json) => _$GBooksFromJson(json);
  Map<String, dynamic> toJson() => _$GBooksToJson(this);
}
