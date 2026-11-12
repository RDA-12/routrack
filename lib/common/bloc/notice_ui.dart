import 'package:equatable/equatable.dart';
import 'package:routrack/core/core.dart';

/// Types of operation
enum OperationType {
  /// Operation that creates new data
  create,

  /// Operation that update existing data
  update,

  /// Operation that delete existing data
  delete,
}

/// Representing data that need to be showed to user
///
/// Typically, in a dialog/toast
sealed class NoticeUI<T> extends Equatable {
  const new();
}

/// Notice changes on [T] from [before] to [after]
final class UpdatedNoticeUI<T> extends NoticeUI<T> {
  /// Creates new [UpdatedNoticeUI]
  const new({required this.before, required this.after});

  /// [T] data before update
  final T before;

  /// [T] data after update
  final T after;

  @override
  List<Object?> get props => [before, after];
}

/// Notice [data] has been deleted
final class DeletedNoticeUI<T> extends NoticeUI<T> {
  /// Creates new [DeletedNoticeUI]
  const new({required this.data});

  /// [T] deleted data
  final T data;

  @override
  List<Object?> get props => [data];
}

/// Notice [data] has been created
final class CreatedNoticeUI<T> extends NoticeUI<T> {
  /// Creates new [CreatedNoticeUI]
  const new({required this.data});

  /// [T] new created data
  final T data;

  @override
  List<Object?> get props => [data];
}

/// Notice that operation [operation] failed on [T] data, throwing [exception]
final class FailedNoticeUI<T> extends NoticeUI<T> {
  /// Creates new [FailedNoticeUI]
  const new({
    required this.data,
    required this.operation,
    required this.exception,
  });

  /// Data used by the [operation]
  ///
  /// Ceates placeholder data of [T] from use case params
  /// when [operation] is [OperationType.create]
  final T data;

  /// Operation that happened
  final OperationType operation;

  /// [AppException] returned by the [operation]
  final AppException exception;

  @override
  List<Object?> get props => [data, operation, exception];
}
