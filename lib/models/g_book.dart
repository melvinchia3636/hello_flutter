import 'package:hello_flutter/models/g_book_volume_info.dart';
import "package:json_annotation/json_annotation.dart";

part "g_book.g.dart";

@JsonSerializable()
class GBook {
  const GBook({
    required this.kind,
    required this.id,
    required this.etag,
    required this.volumeInfo,
  });

  final String kind;
  final String id;
  final String etag;
  final GBookVolumeVolumeInfo volumeInfo;

  factory GBook.fromJson(Map<String, dynamic> json) => _$GBookFromJson(json);
  Map<String, dynamic> toJson() => _$GBookToJson(this);
}
