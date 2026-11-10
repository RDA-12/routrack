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
import 'package:routrack/common/common.dart' as _i336;
import 'package:routrack/common/database/app_database.dart' as _i430;
import 'package:routrack/common/external_module.dart' as _i735;
import 'package:routrack/common/uid_generator.dart' as _i181;
import 'package:routrack/routine/data/repositories/drift_routine_repository.dart'
    as _i85;
import 'package:routrack/routine/domain/domain.dart' as _i547;
import 'package:routrack/routine/domain/repositories/repositories.dart'
    as _i541;
import 'package:routrack/routine/domain/use_cases/create_routine.dart' as _i844;
import 'package:routrack/routine/presentation/bloc/routine_mutation_bloc.dart'
    as _i142;
import 'package:routrack/schedule/domain/repositories/repositories.dart'
    as _i509;
import 'package:routrack/schedule/domain/use_cases/create_schedule_use_case.dart'
    as _i1069;
import 'package:uuid/uuid.dart' as _i706;

const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final externalModule = _$ExternalModule();
    gh.lazySingleton<_i430.AppDatabase>(
      () => _i430.AppDatabase(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i706.Uuid>(
      () => externalModule.uuid,
      registerFor: {_prod},
    );
    gh.lazySingleton<_i454.Clock>(
      () => externalModule.appClock,
      registerFor: {_prod},
    );
    gh.lazySingleton<_i81.AppClock>(
      () => _i81.AppClock(gh<_i454.Clock>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i1069.CreateScheduleUseCase>(
      () => _i1069.CreateScheduleUseCase(
        scheduleRepository: gh<_i509.ScheduleRepository>(),
      ),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i181.UidGenerator>(
      () => _i181.UidGenerator(gh<_i706.Uuid>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i547.RoutineRepository>(
      () => _i85.DriftRoutineRepository(
        db: gh<_i336.AppDatabase>(),
        uidGenerator: gh<_i336.UidGenerator>(),
        clock: gh<_i336.AppClock>(),
      ),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i844.CreateRoutineUseCase>(
      () => _i844.CreateRoutineUseCase(
        routineRepository: gh<_i541.RoutineRepository>(),
      ),
      registerFor: {_prod},
    );
    gh.factory<_i142.RoutineMutationBloc>(
      () => _i142.RoutineMutationBloc(
        createRoutineUseCase: gh<_i547.CreateRoutineUseCase>(),
      ),
      registerFor: {_prod},
    );
    return this;
  }
}

class _$ExternalModule extends _i735.ExternalModule {}
