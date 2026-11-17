// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$homeShellRoute];

RouteBase get $homeShellRoute => ShellRouteData.$route(
  navigatorKey: HomeShellRoute.$navigatorKey,
  factory: $HomeShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/',
      hasOverriddenOnExit: false,
      factory: $HomeRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/routines',
      hasOverriddenOnExit: false,
      factory: $RoutinesListRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'create',
          hasOverriddenOnExit: false,
          parentNavigatorKey: CreateRoutineRoute.$parentNavigatorKey,
          factory: $CreateRoutineRoute._fromState,
        ),
        GoRouteData.$route(
          path: ':id',
          hasOverriddenOnExit: false,
          parentNavigatorKey: RoutineDetailRoute.$parentNavigatorKey,
          factory: $RoutineDetailRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) =>
      const HomeShellRoute();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $RoutinesListRoute on GoRouteData {
  static RoutinesListRoute _fromState(GoRouterState state) =>
      const RoutinesListRoute();

  @override
  String get location => GoRouteData.$location('/routines');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CreateRoutineRoute on GoRouteData {
  static CreateRoutineRoute _fromState(GoRouterState state) =>
      const CreateRoutineRoute();

  @override
  String get location => GoRouteData.$location('/routines/create');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $RoutineDetailRoute on GoRouteData {
  static RoutineDetailRoute _fromState(GoRouterState state) =>
      RoutineDetailRoute(id: state.pathParameters['id']!);

  RoutineDetailRoute get _self => this as RoutineDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/routines/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
