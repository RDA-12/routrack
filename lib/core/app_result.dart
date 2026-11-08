import 'package:equatable/equatable.dart';
import 'package:routrack/core/app_exception.dart';

/// Represent a result from an operation
///
/// It could be [AppResultSuccess<T>] or [AppResultFailed]
sealed class AppResult<T> extends Equatable {
  const new();

  /// Creates new [AppResultSuccess]
  factory success(T data) => AppResultSuccess(data);

  /// Creates new [AppResultFailed]
  factory failed(AppException exception) => AppResultFailed(exception);
}

/// Represent success result of an operation
final class AppResultSuccess<T> extends AppResult<T> {
  /// Creates new [AppResultSuccess]
  const new(this.data);

  /// Data
  final T data;

  @override
  List<Object?> get props => [data];
}

/// Represent failed result of an operation
final class AppResultFailed<T> extends AppResult<T> {
  /// Creates new [AppResultFailed]
  const new(this.exception);

  /// [AppException] that thrown by the failed operation
  final AppException exception;

  @override
  List<Object?> get props => [exception];
}
