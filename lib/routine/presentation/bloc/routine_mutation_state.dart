part of 'routine_mutation_bloc.dart';

/// state for [RoutineMutationBloc]
final class RoutineMutationState extends Equatable {
  /// Creates new [RoutineMutationState]
  const new({
    this.isCreating = false,
    this.notice,
  });

  /// Whether this bloc is creating new routine or not
  final bool isCreating;

  /// Notice that need to be informed to user
  final NoticeUI? notice;

  @override
  List<Object?> get props => [isCreating, notice];
}
