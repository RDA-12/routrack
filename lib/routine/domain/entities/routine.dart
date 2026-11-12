import 'package:equatable/equatable.dart';

/// Represent single user's routine
class Routine extends Equatable {
  /// Creates new [Routine]
  const new({
    required this.id,
    required this.name,
  });

  /// ID of the routine
  final String id;

  /// Name of the routin
  final String name;

  @override
  List<Object?> get props => [id, name];
}
