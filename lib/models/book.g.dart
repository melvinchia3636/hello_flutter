// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      title: json['title'] as String,
      id: json['id'] as String,
      pageCount: json['pageCount'] as int,
      size: json['size'] as int,
      thumbnailUrl: json['thumbnailUrl'] as String,
      downloadUrl: json['downloadUrl'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'thumbnailUrl': instance.thumbnailUrl,
      'downloadUrl': instance.downloadUrl,
    };
