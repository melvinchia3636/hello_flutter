// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'g_books.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GBooks _$GBooksFromJson(Map<String, dynamic> json) => GBooks(
      kind: json['kind'] as String,
      totalItems: json['totalItems'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => GBook.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GBooksToJson(GBooks instance) => <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
