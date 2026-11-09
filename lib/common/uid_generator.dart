import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

/// Provide methods to generate unique ID
@LazySingleton(env: [Environment.prod])
class UidGenerator {
  /// Creates new [UidGenerator]
  const new(this._uuid);

  final Uuid _uuid;

  /// Returns new generated UID
  String generateUid() {
    return _uuid.v4();
  }
}
