part of 'app_router.dart';

/// Route to go to [CreateRoutinePage]
@TypedGoRoute<CreateRoutineRoute>(
  path: '/routines/create',
)
class CreateRoutineRoute extends GoRouteData with $CreateRoutineRoute {
  /// Creates new [CreateRoutineRoute]
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreateRoutinePage();
}
