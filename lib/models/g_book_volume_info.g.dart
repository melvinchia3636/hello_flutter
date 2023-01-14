// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'g_book_volume_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GBookVolumeVolumeInfo _$GBookVolumeVolumeInfoFromJson(
        Map<String, dynamic> json) =>
    GBookVolumeVolumeInfo(
      title: json['title'] as String,
      authors:
          (json['authors'] as List<dynamic>).map((e) => e as String).toList(),
      publishedDate: json['publishedDate'] as String,
      imageLinks: json['imageLinks'] == null
          ? null
          : GBookVolumeInfoImageLinks.fromJson(
              json['imageLinks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GBookVolumeVolumeInfoToJson(
        GBookVolumeVolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publishedDate': instance.publishedDate,
      'imageLinks': instance.imageLinks,
    };
