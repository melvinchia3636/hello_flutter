// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      title: json['name'] as String,
      id: json['id'] as String,
      pageCount: json['page'] as int,
      size: json['size'] as int,
      grade: json['grade'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.title,
      'page': instance.pageCount,
      'size': instance.size,
      'grade': instance.grade,
      'thumbnailUrl': instance.thumbnailUrl,
      'downloadUrl': instance.downloadUrl,
    };
