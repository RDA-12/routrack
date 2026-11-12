part of 'app_router.dart';

/// Route to go to [CreateRoutinePage]
class CreateRoutineRoute extends GoRouteData with $CreateRoutineRoute {
  /// Creates new [CreateRoutineRoute]
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreateRoutinePage();
}

/// Route to go to [RoutinesListPage]
@TypedGoRoute<RoutinesListRoute>(
  path: '/routines',
  routes: [
    TypedGoRoute<CreateRoutineRoute>(path: 'create'),
  ],
)
class RoutinesListRoute extends GoRouteData with $RoutinesListRoute {
  /// Creates new [RoutinesListRoute]
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RoutinesListPage();
}
