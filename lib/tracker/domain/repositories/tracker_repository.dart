import 'package:routrack/common/common.dart';
import 'package:routrack/tracker/domain/entities/entities.dart';
import 'package:routrack/tracker/domain/use_case/use_cases.dart';

/// Repository to manage [Tracker] data
abstract interface class TrackerRepository extends Repository<Tracker>
    with SaveMixin<TrackRoutineParams, Tracker>;
