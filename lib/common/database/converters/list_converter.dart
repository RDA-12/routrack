import 'dart:convert';

import 'package:drift/drift.dart';

/// Converts list of String to database-safe type
class StringListConverter extends TypeConverter<List<String>, String>
    with JsonTypeConverter2<List<String>, String, Map<String, Object?>> {
  /// Creates new [StringListConverter]
  const new();

  @override
  List<String> fromSql(String fromDb) {
    return fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(toJson(value));
  }

  @override
  List<String> fromJson(Map<String, Object?> json) {
    final data = json['data'];
    if (data == null) return [];
    return (data as List<dynamic>).map((it) => it as String).toList();
  }

  @override
  Map<String, Object?> toJson(List<String> value) {
    return {'data': value};
  }
}
