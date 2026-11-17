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

/// Adds [watch] to the [Repository] to watch for list of [T] changes
mixin WatchMixin<T> on Repository<T> {
  /// Watch for list of [T] data changes
  Stream<AppResult<List<T>>> watch();
}

/// Adds [getById] to the [Repository]
mixin GetByIdMixin<T> on Repository<T> {
  /// Returns [T] by [id]
  Future<AppResult<T>> getById(String id);
}

/// Adds [watchById] to the [Repository] to watch for single [T] data
mixin WatchByIdMixin<T> on Repository<T> {
  /// Watch for [T] changes with [id]
  Stream<AppResult<T>> watchById(String id);
}
