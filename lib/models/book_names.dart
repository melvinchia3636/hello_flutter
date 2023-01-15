// To parse this JSON data, do
//
//     final bookNames = bookNamesFromJson(jsonString);

import 'dart:convert';

Map<String, Map<String, String>?>? bookNamesFromJson(String str) =>
    Map.from(json.decode(str)!).map((k, v) =>
        MapEntry<String, Map<String, String>?>(
            k, Map.from(v!).map((k, v) => MapEntry<String, String>(k, v))));

String bookNamesToJson(Map<String, Map<String, String?>?>? data) =>
    json.encode(Map.from(data!).map((k, v) => MapEntry<String, dynamic>(
        k, Map.from(v!).map((k, v) => MapEntry<String, dynamic>(k, v)))));
