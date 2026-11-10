import 'package:material_ui/material_ui.dart';

/// Helper functions to get various data from [ThemeData] from [BuildContext]
extension ThemeX on BuildContext {
  /// Returns [ColorScheme] from this [BuildContext]
  ColorScheme get color => ColorScheme.of(this);

  /// Returns [TextTheme] from this [BuildContext]
  TextTheme get text => TextTheme.of(this);
}
