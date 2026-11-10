// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$createRoutineRoute];

RouteBase get $createRoutineRoute => GoRouteData.$route(
  path: '/routines/create',
  hasOverriddenOnExit: false,
  factory: $CreateRoutineRoute._fromState,
);

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
