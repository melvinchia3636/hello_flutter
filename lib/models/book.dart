import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  Book({
    required this.title,
    required this.id,
    required this.pageCount,
    required this.size,
    this.grade,
    this.thumbnailUrl,
    this.downloadUrl,
  });

  final String id;
  @JsonKey(name: 'name')
  final String title;
  @JsonKey(name: 'page')
  final int pageCount;
  final int size;
  String? grade;
  String? thumbnailUrl;
  String? downloadUrl;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
