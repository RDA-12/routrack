import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

final class _TestException extends Equatable implements Exception {
  const new(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Base class for all exception that might happended within the app
sealed class AppException extends Equatable implements Exception {
  /// Base class for all exception that might happended within the app
  const new(this.message);

  /// Creates new [AppException] for testing purposes
  @visibleForTesting
  factory test() => const UnexpectedException(
    exception: _TestException('message'),
  );

  /// Message for developer
  final String message;

  /// Return String that describe the exception
  ///
  /// Useful for developer to debug the thrown exception.
  String describe() => message;

  @override
  List<Object?> get props => [message];
}

/// Thrown when unexpected failure occurred
final class UnexpectedException extends AppException {
  /// Creates new [UnexpectedException]
  const new({required this.exception}) : super('UnexpectedException');

  /// The thrown [Exception]
  final Exception exception;

  @override
  String describe() {
    return '$message\nException: $exception';
  }

  @override
  List<Object?> get props => super.props + [exception];
}

/// List of entities within this app
enum Entity {
  /// Routine
  routine,

  /// Schedule
  schedule,
}

/// Thrown when requedted entity not found in database
final class NotFoundException extends AppException {
  /// Creates new [NotFoundException]
  const new({
    required this.entity,
    required this.id,
  }) : super('$entity with ID $id is not found');

  /// requested ID
  final String id;

  /// requested entity type
  final Entity entity;

  @override
  List<Object?> get props => super.props + [id, entity];
}
