import 'package:routrack/core/core.dart';

/// {@template Repository}
/// Base class that needs to be implemented by all repositories within this app
/// {@endtemplate}
abstract class Repository<T> {
  /// {@macro Repository}
  const new();
}

/// Adds [save] to the [Repository]
mixin SaveMixin<P, T> on Repository<T> {
  /// Save new [T] based on [params]
  Future<AppResult<T>> save(P params);
}
