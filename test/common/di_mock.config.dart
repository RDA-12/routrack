// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:clock/clock.dart' as _i454;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:routrack/common/app_clock.dart' as _i81;
import 'package:routrack/common/database/database.dart' as _i889;
import 'package:routrack/common/uid_generator.dart' as _i181;
import 'package:routrack/home/home.dart' as _i350;
import 'package:routrack/routine/routine.dart' as _i617;
import 'package:routrack/tracker/tracker.dart' as _i614;
import 'package:uuid/uuid.dart' as _i706;

import '../home/presentation/bloc/home_bloc_mocks.dart' as _i772;
import '../routine/data/repositories/routine_repository_mocks.dart' as _i212;
import '../routine/domain/use_cases/routine_use_cases_mock.dart' as _i170;
import '../routine/presentation/bloc/routine_bloc_mock.dart' as _i477;
import '../tracker/data/repositories/tracker_repository_mocks.dart' as _i68;
import '../tracker/domain/use_cases/tracker_use_cases_mock.dart' as _i982;
import 'app_clock_mock.dart' as _i788;
import 'database/app_database_mock.dart' as _i879;
import 'external_module_mock.dart' as _i888;
import 'uid_generator_mock.dart' as _i247;

const String _test = 'test';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appDatabaseMockModule = _$AppDatabaseMockModule();
    final externalModule = _$ExternalModule();
    gh.lazySingleton<_i617.CreateRoutineUseCase>(
      () => _i170.MockCreateRoutineUseCase(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i617.RoutineMutationBloc>(
      () => _i477.MockRoutineMutationBloc(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i617.WatchRoutines>(
      () => _i170.MockWatchRoutines(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i181.UidGenerator>(
      () => _i247.MockUidGenerator(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i617.RoutineRepository>(
      () => _i212.MockRoutineRepository(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i350.HomeBloc>(
      () => _i772.MockHomeBloc(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i614.TrackerRepository>(
      () => _i68.MockTrackerRepository(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i617.RoutinesBloc>(
      () => _i477.MockRoutinesBloc(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i617.GetRoutineByIdUseCase>(
      () => _i170.MockGetRoutineByIdUseCase(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i614.TrackRoutineUseCase>(
      () => _i982.MockTrackRoutineUseCase(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i81.AppClock>(
      () => _i788.MockAppClock(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i889.AppDatabase>(
      () => appDatabaseMockModule.database,
      registerFor: {_test},
    );
    gh.lazySingleton<_i706.Uuid>(
      () => externalModule.uuid,
      registerFor: {_test},
    );
    gh.lazySingleton<_i454.Clock>(
      () => externalModule.appClock,
      registerFor: {_test},
    );
    return this;
  }
}

class _$AppDatabaseMockModule extends _i879.AppDatabaseMockModule {}

class _$ExternalModule extends _i888.ExternalModule {}
