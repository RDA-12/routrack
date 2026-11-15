import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/router/app_router.dart';

/// Shell for home
///
/// Meant to be used with GoRouter Shell
class HomeShell extends StatelessWidget {
  /// Creates new [HomeShell]
  const new({
    required this.selectedIndex,
    required this.child,
    required this.onDestinationSelected,
    super.key,
  });

  /// Selected destination index
  final int selectedIndex;

  /// [Widget] that will be showed on the shell
  final Widget child;

  /// Invoked when user press a destination
  final void Function(int index) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          unawaited(const CreateRoutineRoute().push<void>(context));
        },
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonLocation: .centerDocked,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_run_rounded),
            label: 'Routines',
          ),
        ],
      ),
    );
  }
}
