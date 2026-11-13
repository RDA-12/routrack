import 'package:equatable/equatable.dart';

/// Representing single track of a routine
class Tracker extends Equatable {
  /// Creates new [Tracker]
  const new({required this.id, required this.routineId, required this.date});

  /// ID of this tracker
  final String id;

  /// ID of the routine tracked by this tracker
  final String routineId;

  /// When the routine is tracked
  final DateTime date;

  @override
  List<Object?> get props => [id, routineId, date];
}
