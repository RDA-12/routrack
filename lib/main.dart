import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';

void main() {
  initializeDependencies();
  runApp(const RoutrackApp());
}

/// Main widget of the app
class RoutrackApp extends StatelessWidget {
  /// Creates new [RoutrackApp]
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.config,
    );
  }
}
