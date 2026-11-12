// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$routinesListRoute];

RouteBase get $routinesListRoute => GoRouteData.$route(
  path: '/routines',
  hasOverriddenOnExit: false,
  factory: $RoutinesListRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'create',
      hasOverriddenOnExit: false,
      factory: $CreateRoutineRoute._fromState,
    ),
  ],
);

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
