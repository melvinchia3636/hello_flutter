import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  Book({
    required this.title,
    required this.id,
    required this.pageCount,
    required this.size,
    required this.thumbnailUrl,
    required this.downloadUrl,
  });

  final String id;
  final String title;
  final int pageCount;
  final int size;
  final String thumbnailUrl;
  final String downloadUrl;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
