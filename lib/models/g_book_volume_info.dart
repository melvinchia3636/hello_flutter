import 'package:hello_flutter/models/g_book_volume_info_image_links.dart';
import "package:json_annotation/json_annotation.dart";

part "g_book_volume_info.g.dart";

@JsonSerializable()
class GBookVolumeVolumeInfo {
  const GBookVolumeVolumeInfo({
    required this.title,
    required this.authors,
    required this.publishedDate,
    this.imageLinks,
  });

  final String title;
  final List<String> authors;
  final String publishedDate;
  final GBookVolumeInfoImageLinks? imageLinks;

  factory GBookVolumeVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$GBookVolumeVolumeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GBookVolumeVolumeInfoToJson(this);
}
