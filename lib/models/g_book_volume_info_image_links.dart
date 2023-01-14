import 'package:json_annotation/json_annotation.dart';

part 'g_book_volume_info_image_links.g.dart';

@JsonSerializable()
class GBookVolumeInfoImageLinks {
  const GBookVolumeInfoImageLinks({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  final String smallThumbnail;
  final String thumbnail;

  factory GBookVolumeInfoImageLinks.fromJson(Map<String, dynamic> json) =>
      _$GBookVolumeInfoImageLinksFromJson(json);
  Map<String, dynamic> toJson() => _$GBookVolumeInfoImageLinksToJson(this);
}
