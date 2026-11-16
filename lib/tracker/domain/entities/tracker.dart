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

  /// Returns whether this [Tracker]'s date is in same day as [date]
  bool isSameDayAs(DateTime date) {
    final localTrackerDate = this.date.toLocal();
    final localDate = date.toLocal();
    return localTrackerDate.day == localDate.day &&
        localTrackerDate.month == localDate.month &&
        localTrackerDate.year == localDate.year;
  }

  @override
  List<Object?> get props => [id, routineId, date];
}
