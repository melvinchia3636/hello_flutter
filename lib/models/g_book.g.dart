// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'g_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GBook _$GBookFromJson(Map<String, dynamic> json) => GBook(
      kind: json['kind'] as String,
      id: json['id'] as String,
      etag: json['etag'] as String,
      volumeInfo: GBookVolumeVolumeInfo.fromJson(
          json['volumeInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GBookToJson(GBook instance) => <String, dynamic>{
      'kind': instance.kind,
      'id': instance.id,
      'etag': instance.etag,
      'volumeInfo': instance.volumeInfo,
    };
