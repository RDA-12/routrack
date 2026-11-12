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
class RoutinesListRoute extends GoRouteData with $RoutinesListRoute {
  /// Creates new [RoutinesListRoute]
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RoutinesListPage();
}

/// Route to go to [HomePage]
class HomeRoute extends GoRouteData with $HomeRoute {
  /// Creates new [HomeRoute]
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

/// Home [ShellRoute]
@TypedShellRoute<HomeShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(path: '/'),
    TypedGoRoute<RoutinesListRoute>(
      path: '/routines',
      routes: [
        TypedGoRoute<CreateRoutineRoute>(path: 'create'),
      ],
    ),
  ],
)
class HomeShellRoute extends ShellRouteData {
  /// Creates new [HomeShellRoute]
  const new();

  int _indexOf(String location) {
    if (location.startsWith('/routines')) return 1;
    return 0;
  }

  String _locationOf(int index) {
    if (index == 1) return '/routines';
    return '/';
  }

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return HomeShell(
      selectedIndex: _indexOf(state.matchedLocation),
      onDestinationSelected: (index) {
        final location = _locationOf(index);
        context.go(location);
      },
      child: navigator,
    );
  }
}
