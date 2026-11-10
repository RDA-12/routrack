import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:routrack/common/database/converters/converters.dart';

void main() {
  group('StringListConverter', () {
    test('fromSql', () {
      const converter = StringListConverter();

      final expected = ['a', 'b'];
      final actual = converter.fromSql(jsonEncode({'data': expected}));

      expect(actual, expected);
    });

    test('toSql', () {
      const converter = StringListConverter();

      final expected = jsonEncode({
        'data': ['a', 'b'],
      });
      final actual = converter.toSql(['a', 'b']);

      expect(actual, expected);
    });
  });
}
