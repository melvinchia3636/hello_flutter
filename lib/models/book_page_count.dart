// To parse this JSON data, do
//
//     final bookNames = bookNamesFromJson(jsonString);

import 'dart:convert';

Map<String, Map<String, int>?>? bookPageCountFromJson(String str) =>
    Map.from(json.decode(str)!).map((k, v) =>
        MapEntry<String, Map<String, int>?>(
            k, Map.from(v!).map((k, v) => MapEntry<String, int>(k, v))));

String bookPageCountToJson(Map<String, Map<String, int>?>? data) =>
    json.encode(Map.from(data!).map((k, v) => MapEntry<String, dynamic>(
        k, Map.from(v!).map((k, v) => MapEntry<String, dynamic>(k, v)))));
