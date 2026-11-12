import 'package:routrack/core/core.dart';

/// Use case contract for Future operations
///
/// [P] is param type for the call method. Typically a DTO object that also used
/// by data layer or a custom use case params object
///
/// [R] is result type returned by the use case. It wrapped with [AppResult].
abstract interface class FutureUseCase<P, R> {
  /// Executing this use case
  Future<AppResult<R>> call(P params);
}

/// Use case contract for Stream operations
///
/// [P] is param type for the call method
///
/// [R] is data type streamed by the use case. It wrapped with [AppResult].
abstract interface class StreamUseCase<P, R> {
  /// Returns stream data of [R]
  Stream<AppResult<R>> call([P params]);
}
