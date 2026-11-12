import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/home/home.dart';
import 'package:routrack/routine/routine.dart';

part 'app_routes.dart';
part 'app_router.g.dart';

/// App router config
abstract class AppRouter {
  /// Config for app router
  static final config = GoRouter(
    initialLocation: '/',
    routes: $appRoutes,
  );
}
